#!/usr/bin/env python3
"""Scaffold and register LuCI themes.

  scaffold.py new <slug> <Name> [--light] [--color #rrggbb] [--tag "gallery blurb"] [--title "..."]
  scaffold.py sync            # regenerate install.sh list, README gallery/count/names from tools/themes.tsv

<Name> becomes the uci key (luci.themes.<Name>), so it must be letters/digits only (no '-' or spaces).
Existing theme folders are never modified by `new`; `sync` only touches install.sh and README.md.
"""
import os, re, shutil, subprocess, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
TPL = os.path.join(ROOT, 'tools', 'template')
TSV = os.path.join(ROOT, 'tools', 'themes.tsv')
WORDS = 'zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen'.split()
TENS = {20: 'twenty', 30: 'thirty', 40: 'forty', 50: 'fifty'}

DARK = dict(font='system-ui, -apple-system, "Segoe UI", Roboto, sans-serif', fs='14px', scheme='dark', bsign=1, tsign=-1,
            bh=210, bs='15%', bl='10%', th=210, ts='10%', tl='88%', bg='#10151c', card='#161d27', head='#0c1117',
            ink='#e3e9f1', dim='#8b98a9', rule='#2a3442', hover='#1e2733', accent='#4cc2ff', accent2='#7ad7ff', on='#04121c',
            hborder='1px solid var(--t-rule)', rad='6px', brad='4px', pop='0 10px 30px rgba(0,0,0,.4)', shadow='none',
            overlay='rgba(0,0,0,.6)', err_rgb='229, 72, 77', ok_rgb='62, 207, 142', err='#e5484d', ok='#3ecf8e',
            warn='#f5a524', focus='76, 194, 255')
LIGHT = dict(DARK, scheme='light', bsign=-1, tsign=1, bh=210, bs='25%', bl='96%', th=215, ts='25%', tl='15%', bg='#f4f6f9',
             card='#ffffff', head='#ffffff', ink='#1b2430', dim='#5b6778', rule='#d5dce6', hover='#e8edf4', accent='#1f5fd1',
             accent2='#1749a3', on='#ffffff', pop='0 10px 30px rgba(0,0,0,.18)', overlay='rgba(240,244,250,.8)',
             err='#c0302f', err_rgb='192, 48, 47', ok='#1f8a5a', ok_rgb='31, 138, 90', warn='#9a6a00', focus='31, 95, 209')


def words(n):
    if n < 20: return WORDS[n].capitalize()
    t, o = divmod(n, 10)
    return (TENS[t * 10] + ('-' + WORDS[o] if o else '')).capitalize()


def rule(sel, decls):
    sel = ',\n'.join(p.strip() for p in sel.split(','))
    body = '\n'.join('\t' + d.strip() for d in decls.strip().split('\n') if d.strip())
    return sel + ' {\n' + body + '\n}\n\n'


def default_buttons(rad):
    D = '.btn, .cbi-button, input[type="button"], input[type="submit"], input[type="reset"]'
    A = '.cbi-button-action, .cbi-button-edit, .cbi-button-reload, .cbi-section-actions .cbi-button-edit, .btn.cbi-button-action'
    P = '.cbi-button-apply, .cbi-page-actions .cbi-button-apply, .btn.primary, .cbi-button-action.important'
    S = ('.cbi-button-positive, .cbi-button-fieldadd, .cbi-button-add, .cbi-button-save, .cbi-page-actions .cbi-button-save, '
         '.cbi-page-actions .cbi-button-apply + .cbi-button-save, .cbi-page-actions .cbi-button-negative + .cbi-button-save')
    N = '.cbi-button-negative, .cbi-section-remove .cbi-button, .cbi-button-remove, .cbi-button-reset'
    hov = lambda s: ',\n'.join(p.strip() + ':hover' for p in s.split(','))
    base = ('--on-color: var(--t-ink);\nbackground: transparent;\nborder: 1px solid var(--t-accent);\nborder-radius: %s;\n'
            'text-shadow: none;\nbox-shadow: none;\ntransition: background .15s, color .15s;' % rad)
    fill = 'background: var(--t-accent);\n--on-color: var(--t-on);\nborder-color: var(--t-accent);\nbox-shadow: none !important;'
    out = rule(D, base) + rule(hov(D), fill) + rule(A, base) + rule(hov(A), fill)
    out += rule(P, '--on-color: var(--t-on);\nbackground: var(--t-accent);\nborder: 1px solid var(--t-accent);\nfont-weight: 700;\nbox-shadow: none;')
    out += rule(hov(P), '--on-color: var(--t-on);\nbackground: var(--t-accent2);\nborder-color: var(--t-accent2);\nbox-shadow: none !important;')
    out += rule(S, base + '\nfont-weight: 700;') + rule(hov(S), fill)
    out += rule(N, '--on-color: var(--t-err);\nbackground: transparent;\nborder: 1px solid var(--t-err);')
    out += rule(hov(N), '--on-color: #fff;\nbackground: var(--t-err);\nborder-color: var(--t-err);\nbox-shadow: none !important;')
    return out


def clock_script():
    return ("<script>(function(){var e=document.getElementById('hdr-clock');if(!e)return;function p(n){return (n<10?'0':'')+n}"
            "function t(){var d=new Date();e.textContent=p(d.getHours())+':'+p(d.getMinutes())+':'+p(d.getSeconds())}"
            "t();setInterval(t,1000)})();</script>")


def read_tsv():
    rows = []
    for ln in open(TSV, encoding='utf-8'):
        if ln.strip():
            rows.append(ln.rstrip('\n').split('\t'))
    return rows


def new(slug, name, light, color, tag, title):
    if not re.fullmatch(r'[a-z][a-z0-9]{1,15}', slug): sys.exit('slug: lowercase letters/digits, 2-16 chars')
    if not re.fullmatch(r'[A-Za-z][A-Za-z0-9]*', name): sys.exit('Name becomes a uci option name: letters/digits only (no "-" or spaces)')
    dst = os.path.join(ROOT, 'luci-theme-' + slug)
    if os.path.exists(dst): sys.exit('%s already exists; refusing to touch an existing theme' % dst)
    title = title or '%s Theme' % name
    color = color or ('#f4f6f9' if light else '#0c1117')
    for r, _, fs in os.walk(os.path.join(TPL, 'files')):
        for fn in fs:
            src = os.path.join(r, fn)
            rel = os.path.relpath(src, os.path.join(TPL, 'files')).replace('__SLUG__', slug)
            out = os.path.join(dst, rel)
            os.makedirs(os.path.dirname(out), exist_ok=True)
            if fn == 'mobile.css':
                shutil.copy(src, out); continue
            s = open(src, encoding='utf-8').read()
            s = (s.replace('__SLUG__', slug).replace('__NAME__', name).replace('__TITLE__', title)
                 .replace('__DARKPREF__', 'false' if light else 'true').replace('__DARKCOMMENT__', 'light theme' if light else 'dark-only theme')
                 .replace('__THEMECOLOR__', color).replace('__CLOCK_SCRIPT__', clock_script()))
            open(out, 'w', encoding='utf-8').write(s)
            if fn == 'install.sh': os.chmod(out, 0o755)
    p = dict(DARK if not light else LIGHT)
    css = open(os.path.join(TPL, 'override.css.tpl'), encoding='utf-8').read()
    for k, v in p.items(): css = css.replace('@@%s@@' % k, str(v))
    css = css.replace('@@DESC@@', tag or 'Starter palette; restyle everything below.').replace('@@NAME@@', name)
    css = css.replace('@@BUTTONS@@', default_buttons(p['rad']))
    assert '@@' not in css
    base = open(os.path.join(TPL, 'base.css'), encoding='utf-8').read().replace('__NAME__', name)
    stat = os.path.join(dst, 'htdocs', 'luci-static', slug)
    open(os.path.join(stat, 'cascade.css'), 'w', encoding='utf-8').write(base + '\n' + css)
    svg = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="%s"/>'
           '<circle cx="50" cy="50" r="26" fill="none" stroke="%s" stroke-width="8"/></svg>' % (p['bg'], p['accent']))
    open(os.path.join(stat, 'logo.svg'), 'w').write(svg)
    open(os.path.join(dst, 'README.md'), 'w').write(
        '# luci-theme-%s\n\n%s: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). %s theme.\n\n'
        '%s\n\n## Install on a router\n    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s %s\n\n'
        'Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or\n'
        '`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.\n' % (slug, name, 'Light' if light else 'Dark', tag or '', slug))
    render_png(stat)
    with open(TSV, 'a', encoding='utf-8') as f:
        f.write('\t'.join([slug, name, 'Light' if light else 'Dark', tag or title]) + '\n')
    sync()
    print('created luci-theme-%s (edit %s/cascade.css, replace logo.svg, then run tools/check-theme.sh %s)' % (slug, os.path.relpath(stat, ROOT), slug))


def render_png(stat):
    """logo_48.png from logo.svg (ImageMagick or rsvg-convert)."""
    svg, png = os.path.join(stat, 'logo.svg'), os.path.join(stat, 'logo_48.png')
    for cmd in (['rsvg-convert', '-w', '48', '-h', '48', svg, '-o', png],
                ['convert', '-background', 'none', '-density', '384', svg, '-resize', '48x48', png]):
        if shutil.which(cmd[0]):
            subprocess.run(cmd, check=True); return
    print('warning: no rsvg-convert/convert; create %s by hand' % png)


def sync():
    rows = read_tsv()
    slugs = [r[0] for r in rows]
    for s in slugs:
        if not os.path.isdir(os.path.join(ROOT, 'luci-theme-' + s)): sys.exit('themes.tsv lists %s but the folder is missing' % s)
    # install.sh
    p = os.path.join(ROOT, 'install.sh'); s = open(p).read()
    s, n = re.subn(r'^THEMES="[^"]*"', 'THEMES="%s"' % ' '.join(slugs), s, flags=re.M); assert n == 1
    s, n = re.subn(r'^#   themes: .*$', '#   themes: ' + ' '.join(slugs), s, flags=re.M); assert n == 1
    open(p, 'w').write(s)
    # README
    p = os.path.join(ROOT, 'README.md'); s = open(p, encoding='utf-8').read()
    cells = []
    for slug, disp, mode, desc in rows:
        cells.append('<td width="50%%" valign="top">\n<a href="luci-theme-%s"><img src="docs/screenshots/%s-overview.jpg" alt="%s theme" width="100%%"></a><br>\n'
                     '<b>%s</b> &middot; <sub>%s</sub><br>\n<sub>%s</sub><br>\n<sub><code>sh -s %s</code></sub>\n</td>' % (slug, slug, disp, disp, mode, desc, slug))
    trs = ''.join('<tr>' + cells[i] + (cells[i + 1] if i + 1 < len(cells) else '<td></td>') + '</tr>\n' for i in range(0, len(cells), 2))
    s, n = re.subn(r'<!-- GALLERY:START -->.*?<!-- GALLERY:END -->', lambda m: '<!-- GALLERY:START -->\n<table>\n' + trs + '</table>\n<!-- GALLERY:END -->', s, flags=re.S); assert n == 1
    names = ', '.join('`%s`' % x for x in slugs)
    s, n = re.subn(r'<!-- NAMES:START -->.*?<!-- NAMES:END -->', lambda m: '<!-- NAMES:START -->' + names + '<!-- NAMES:END -->', s, flags=re.S); assert n == 1
    s, n = re.subn(r'\*\*\w+(?:-\w+)? custom themes for', '**%s custom themes for' % words(len(slugs)), s); assert n == 1
    s, n = re.subn(r'themes-\d+-6f42c1', 'themes-%d-6f42c1' % len(slugs), s); assert n == 1
    open(p, 'w', encoding='utf-8').write(s)
    print('synced %d themes' % len(slugs))


if __name__ == '__main__':
    a = sys.argv[1:]
    if a[:1] == ['sync']: sync()
    elif a[:1] == ['new'] and len(a) >= 3:
        opts = {'light': False, 'color': None, 'tag': None, 'title': None}
        i = 3
        while i < len(a):
            if a[i] == '--light': opts['light'] = True; i += 1
            elif a[i] in ('--color', '--tag', '--title'): opts[a[i][2:]] = a[i + 1]; i += 2
            else: sys.exit('unknown option ' + a[i])
        new(a[1], a[2], **opts)
    else: print(__doc__); sys.exit(1)
