// Renders every theme against a mock LuCI page filled with made-up data and writes
// docs/screenshots/<theme>-{overview,settings}.jpg.
//   node tools/previews/make-previews.js [theme ...]      (or: tools/screenshots.sh [theme ...])
// Env: OUT_DIR=<dir> to write elsewhere. Needs `playwright` (npm i playwright) with a Chromium.
// No router or real data involved.
const fs = require('fs'), path = require('path'), os = require('os');
const { chromium } = require('playwright');
const { ROOT, pageHtml } = require('./mock');

const OUT = process.env.OUT_DIR || path.join(ROOT, 'docs', 'screenshots');
fs.mkdirSync(OUT, { recursive: true });
const themes = fs.readdirSync(ROOT).filter(d => d.startsWith('luci-theme-')).map(d => d.slice(11)).sort();
const only = process.argv.slice(2);

(async () => {
  const b = await chromium.launch();
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'owt-prev-'));
  for (const t of themes) {
    if (only.length && !only.includes(t)) continue;
    for (const tod of (t === 'circadian' ? ['dawn', 'day', 'dusk', 'night'] : [''])) {
      for (const page of ['overview', 'settings']) {
        const f = path.join(tmp, `${t}-${page}.html`);
        fs.writeFileSync(f, pageHtml(t, page, tod));
        const p = await b.newPage({ viewport: { width: 1280, height: page === 'overview' ? 760 : 920 } });
        await p.goto('file://' + f);
        if (tod) await p.evaluate(tod => { const e = document.getElementById('hdr-clock'); if (e) e.textContent = tod.toUpperCase() + ' 12:00:00'; }, tod);
        if (page === 'overview') await p.hover('#topmenu > li:nth-child(4) > a');
        await p.waitForTimeout(400);
        const name = `${t}${tod && tod !== 'dusk' ? '-' + tod : ''}-${page}.jpg`;
        await p.screenshot({ path: path.join(OUT, name), type: 'jpeg', quality: 86 });
        await p.close();
        console.log('wrote', name);
      }
    }
  }
  await b.close();
})();
