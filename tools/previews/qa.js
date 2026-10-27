// Per-theme QA on the mock pages: horizontal overflow at phone width, focus visibility,
// text contrast on common elements, and a phone-width screenshot for eyeballing.
//   node tools/previews/qa.js <theme> [theme...]     (or: tools/check-theme.sh <theme> runs this too)
// Env: QA_DIR=<dir> for the phone screenshots (default /tmp/owt-qa). Contrast on gradients/images is approximate.
const fs = require('fs'), path = require('path'), os = require('os');
const { chromium } = require('playwright');
const { pageHtml } = require('./mock');
const OUT = process.env.QA_DIR || '/tmp/owt-qa';
fs.mkdirSync(OUT, { recursive: true });

function probe() {
  const lum = c => { const [r, g, b] = c.map(v => { v /= 255; return v <= .03928 ? v / 12.92 : Math.pow((v + .055) / 1.055, 2.4); }); return .2126 * r + .7152 * g + .0722 * b; };
  const parse = s => { const m = s.match(/rgba?\(([^)]+)\)/); if (!m) return null; const p = m[1].split(/[ ,\/]+/).filter(Boolean).map(Number); return { c: p.slice(0, 3), a: p.length > 3 ? p[3] : 1 }; };
  const bgOf = el => { // blend ancestors' background colours down to the page
    const stack = []; for (let e = el; e; e = e.parentElement) { const p = parse(getComputedStyle(e).backgroundColor); if (p && p.a > 0) { stack.push(p); if (p.a >= 1) break; } }
    let base = [255, 255, 255]; const root = parse(getComputedStyle(document.documentElement).backgroundColor); if (root && root.a > 0) base = root.c;
    if (!stack.length || stack[stack.length - 1].a < 1) { const top = stack.length && stack[stack.length - 1]; if (!top) return base; }
    let col = stack[stack.length - 1].a >= 1 ? stack[stack.length - 1].c : base;
    for (let i = stack.length - (stack[stack.length - 1].a >= 1 ? 2 : 1); i >= 0; i--) col = col.map((v, k) => v * (1 - stack[i].a) + stack[i].c[k] * stack[i].a);
    return col; };
  const ratio = (a, b) => { const x = lum(a), y = lum(b); return (Math.max(x, y) + .05) / (Math.min(x, y) + .05); };
  const sels = ['body', '.cbi-value-title', '.cbi-value-field', '.cbi-map-descr', 'h2', 'h3', 'a', '.th', '.td', 'input[type=text]', 'select',
    '.cbi-button-apply', '.cbi-button-save', '.cbi-button-negative', '.cbi-button-action', '.label', '.alert-message', '.nav a', 'footer'];
  const out = [];
  for (const s of sels) { const el = document.querySelector(s); if (!el) continue; const cs = getComputedStyle(el); const fg = parse(cs.color); if (!fg) continue;
    const bg = bgOf(el); const r = ratio(fg.c, bg); out.push({ s, r: Math.round(r * 10) / 10 }); }
  return out;
}

(async () => {
  const b = await chromium.launch(); let bad = 0;
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'owt-qa-'));
  for (const t of process.argv.slice(2)) {
    for (const page of ['overview', 'settings']) {
      const f = path.join(tmp, `${t}-${page}.html`); fs.writeFileSync(f, pageHtml(t, page, t === 'circadian' ? 'night' : ''));
      const p = await b.newPage({ viewport: { width: 390, height: 844 } });
      await p.goto('file://' + f); await p.waitForTimeout(300);
      const ov = await p.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
      if (ov > 2) { bad++; console.log(`  [${t}/${page}] horizontal overflow at 390px: ${ov}px`); }
      await p.screenshot({ path: path.join(OUT, `${t}-${page}-phone.png`), fullPage: false });
      await p.close();
      const d = await b.newPage({ viewport: { width: 1280, height: 900 } });
      await d.goto('file://' + f); await d.waitForTimeout(300);
      const rows = await d.evaluate(probe);
      if (process.env.QA_VERBOSE) console.log(t, page, rows.map(r => r.s + '=' + r.r).join(' '));
      for (const r of rows) if (r.r < 4.5) { bad++; console.log(`  [${t}/${page}] low contrast ${r.r}:1 on ${r.s}`); }
      if (page === 'settings') {
        for (const s of ['input[type=text]', '.cbi-button-apply']) {
          await d.focus(s); await d.keyboard.press('Shift+Tab'); await d.keyboard.press('Tab');
          const vis = await d.evaluate(s => { const cs = getComputedStyle(document.querySelector(s)); return (cs.outlineStyle !== 'none' && parseFloat(cs.outlineWidth) > 0) || (cs.boxShadow && cs.boxShadow !== 'none') || cs.borderColor; }, s);
          if (!vis) { bad++; console.log(`  [${t}] no visible focus style on ${s}`); }
        }
      }
      await d.close();
    }
    console.log(`${t}: QA done (phone screenshots in ${OUT})`);
  }
  await b.close(); process.exit(bad ? 2 : 0);
})();
