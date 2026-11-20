"""Helper for writing a theme's stylesheet in one script.

    import sys; sys.path.insert(0, 'tools/lib')
    from build_theme import make, buttons, hsl

A theme script describes a palette `p`, extra CSS (`extra`), button styles (`btn`) and a logo (`svg`),
then calls make(). make() scaffolds the theme with tools/new-theme.sh if it does not exist yet, fills the
shared override template with the palette, appends `extra` and the shared accessibility baseline, and writes
cascade.css, logo.svg and logo_48.png. See tools/BATCH_WORKFLOW.md for the whole weekly procedure.
"""
import colorsys, os, subprocess, sys

REPO = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
sys.path.insert(0, os.path.dirname(__file__))
import scaffold  # noqa: E402

DEFAULT = '.btn, .cbi-button, input[type="button"], input[type="submit"], input[type="reset"]'
ACTION = '.cbi-button-action, .cbi-button-edit, .cbi-button-reload, .cbi-section-actions .cbi-button-edit, .btn.cbi-button-action'
APPLY = '.cbi-button-apply, .cbi-page-actions .cbi-button-apply, .btn.primary, .cbi-button-action.important'
SAVE = ('.cbi-button-positive, .cbi-button-fieldadd, .cbi-button-add, .cbi-button-save, '
        '.cbi-page-actions .cbi-button-save, .cbi-page-actions .cbi-button-apply + .cbi-button-save, '
        '.cbi-page-actions .cbi-button-negative + .cbi-button-save')
NEG = '.cbi-button-negative, .cbi-section-remove .cbi-button, .cbi-button-remove, .cbi-button-reset'


def _hov(sel):
    return ',\n'.join(p.strip() + ':hover' for p in sel.split(','))


def _rule(sel, decls):
    sel = ',\n'.join(p.strip() for p in sel.split(','))
    body = '\n'.join('\t' + d.strip() for d in decls.strip().split('\n') if d.strip())
    return sel + ' {\n' + body + '\n}\n\n'


def buttons(default, default_hover, action, action_hover, apply_, apply_hover, save, save_hover, neg, neg_hover):
    """Button rules with the same specificity as the base theme. Text colour comes from --on-color."""
    out = _rule(DEFAULT, default) + _rule(_hov(DEFAULT), default_hover)
    out += _rule(ACTION, action) + _rule(_hov(ACTION), action_hover)
    out += _rule(APPLY, apply_) + _rule(_hov(APPLY), apply_hover)
    out += _rule(SAVE, save) + _rule(_hov(SAVE), save_hover)
    out += _rule(NEG, neg) + _rule(_hov(NEG), neg_hover)
    return out


def hsl(hexc):
    h = hexc.lstrip('#')
    r, g, b = [int(h[i:i + 2], 16) / 255 for i in (0, 2, 4)]
    hh, ll, ss = colorsys.rgb_to_hls(r, g, b)
    return round(hh * 360), '%d%%' % round(ss * 100), '%d%%' % round(ll * 100)


def _sh(c):
    subprocess.run(c, shell=True, check=True)


def make(slug, name, tag, title, light, color, p, extra, btn, svg, batch):
    """batch is the release date, YYYY-MM-DD (the Friday)."""
    d0 = f'{REPO}/themes/luci-theme-{slug}'
    if not os.path.isdir(d0):
        _sh(f"cd {REPO} && tools/new-theme.sh {slug} {name} {'--light' if light else ''} --color '{color}' "
            f"--tag \"{tag}\" --title \"{title}\" --batch {batch}")
    d = dict(scaffold.LIGHT if light else scaffold.DARK)
    bh, bs, bl = hsl(p['bg'])
    th, ts, tl = hsl(p['ink'])
    d.update(bh=bh, bs=bs, bl=bl, th=th, ts=ts, tl=tl)
    d.update(p)
    css = open(f'{REPO}/tools/template/override.css.tpl').read()
    head, tail = css.split('/* --- Accessibility and small-screen baseline')
    tail = '/* --- Accessibility and small-screen baseline' + tail
    for k, v in d.items():
        head = head.replace('@@%s@@' % k, str(v))
        tail = tail.replace('@@%s@@' % k, str(v))
    head = head.replace('@@DESC@@', tag).replace('@@NAME@@', name).replace('__NAME__', name).replace('@@BUTTONS@@', btn)
    assert '@@' not in head, [l for l in head.split('\n') if '@@' in l][:3]
    base = open(f'{REPO}/tools/template/base.css').read().replace('__NAME__', name)
    out = base + '\n' + head + extra + '\n' + tail
    assert out.count('{') == out.count('}'), (slug, 'unbalanced braces', out.count('{'), out.count('}'))
    stat = f'{d0}/htdocs/luci-static/{slug}'
    open(f'{stat}/cascade.css', 'w').write(out)
    open(f'{stat}/logo.svg', 'w').write(svg)
    scaffold.render_png(stat)
