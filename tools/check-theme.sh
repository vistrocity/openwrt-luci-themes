#!/bin/sh
# Static checks for one or more themes (run before every release):
#   tools/check-theme.sh <slug> [slug...]       add --qa to also run the browser QA (phone width, contrast, focus)
# Checks: file layout, CSS brace balance, leftover template tokens, uci key has no '-', registration in
# install.sh and tools/themes.tsv, ucode pitfalls in inline scripts, logo files, shell syntax,
# reduced-motion guard for animated themes, and a few third-party brand words.
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
QA=0; THEMES=""
for a in "$@"; do [ "$a" = "--qa" ] && QA=1 || THEMES="$THEMES $a"; done
[ -n "$THEMES" ] || { sed -n '2,6p' "$0"; exit 1; }
FAIL=0
bad() { echo "  FAIL $1"; FAIL=1; }
for t in $THEMES; do
	d="$ROOT/luci-theme-$t"; echo "== $t"
	[ -d "$d" ] || { bad "missing folder"; continue; }
	st="$d/htdocs/luci-static/$t"
	for f in Makefile README.md install.sh "root/etc/uci-defaults/30_luci-theme-$t" "htdocs/luci-static/$t/cascade.css" "htdocs/luci-static/$t/mobile.css" \
		"htdocs/luci-static/$t/logo.svg" "htdocs/luci-static/$t/logo_48.png" "htdocs/luci-static/resources/menu-$t.js" \
		"htdocs/luci-static/resources/view/$t/sysauth.js" "ucode/template/themes/$t/header.ut" "ucode/template/themes/$t/footer.ut" "ucode/template/themes/$t/sysauth.ut"; do
		[ -f "$d/$f" ] || bad "missing $f"
	done
	css="$st/cascade.css"
	python3 - "$css" "$t" <<'PY' || FAIL=1
import re, sys
s = open(sys.argv[1], encoding='utf-8').read(); t = sys.argv[2]; ok = True
def bad(m):
    global ok; ok = False; print('  FAIL ' + m)
if s.count('{') != s.count('}'): bad('unbalanced braces %d/%d' % (s.count('{'), s.count('}')))
if s.count('(') != s.count(')'): bad('unbalanced parentheses')
for tok in ('@@', '__SLUG__', '__NAME__', '__TITLE__'):
    if tok in s: bad('leftover token ' + tok)
if t != 'mission' and re.search(r'mission', s, re.I): bad("leftover 'mission' reference")
if re.search(r'animation\s*:|@keyframes', s) and 'prefers-reduced-motion' not in s: bad('animations without a prefers-reduced-motion guard')
if ':focus-visible' not in s and ':focus' not in s: bad('no focus styles')
if not re.search(r'cbi-progressbar[^{]*\{[^}]*\}', s): bad('no progress bar styling')
m = re.search(r'\.cbi-progressbar\s*\{[^}]*overflow\s*:\s*hidden', s)
if m: bad('overflow:hidden on .cbi-progressbar clips its label')
for w in ('nintendo', 'game boy', 'gameboy', 'playstation', 'xbox', 'sega ', 'tfl ', 'london underground', 'google', 'microsoft', 'apple '):
    if w in s.lower().split('/*!')[0] or re.search(r'(?i)(?<=\* )[^\n]*' + re.escape(w), s[s.find('overrides'):]):
        print('  WARN brand word in CSS: ' + w)
sys.exit(0 if ok else 1)
PY
	for f in install.sh "root/etc/uci-defaults/30_luci-theme-$t"; do sh -n "$d/$f" 2>/dev/null || bad "shell syntax: $f"; done
	grep -hE 'luci\.themes\.[A-Za-z0-9_-]+' "$d/install.sh" "$d/root/etc/uci-defaults/30_luci-theme-$t" "$d/Makefile" 2>/dev/null | grep -qE 'luci\.themes\.[A-Za-z0-9_]*-' && bad "uci key contains '-' (uci rejects it)"
	grep -q "luci.themes.[A-Za-z0-9]*=/luci-static/$t" "$d/install.sh" || bad "install.sh does not register /luci-static/$t"
	grep -q "^THEMES=.*\b$t\b" "$ROOT/install.sh" || bad "not listed in top-level install.sh (run tools/new-theme.sh --sync)"
	grep -q "^$t	" "$ROOT/tools/themes.tsv" || bad "not in tools/themes.tsv"
	grep -q "const darkpref = '\(true\|false\)'" "$d/ucode/template/themes/$t/header.ut" || bad "header.ut darkpref missing"
	grep -q "hdr-clock" "$d/ucode/template/themes/$t/header.ut" || echo "  note: header.ut has no hdr-clock (fine for legacy themes; the mock-page clock is skipped)"
	python3 - "$d/ucode/template/themes/$t" <<'PY' || FAIL=1
import re, sys, glob
ok = True
for f in glob.glob(sys.argv[1] + '/*.ut'):
    for m in re.finditer(r'<script>(.*?)</script>', open(f, encoding='utf-8').read(), re.S):
        if re.search(r'\{\{|\{%|\{#', m.group(1)) :
            ok = False; print('  FAIL ucode would parse "{{" / "{%" / "{#" inside inline script in ' + f)
sys.exit(0 if ok else 1)
PY
	xmllint --noout "$st/logo.svg" 2>/dev/null || bad "logo.svg is not valid XML"
	if command -v identify >/dev/null; then [ "$(identify -format '%wx%h' "$st/logo_48.png" 2>/dev/null)" = "48x48" ] || bad "logo_48.png is not 48x48"; fi
	if [ "$(grep -o '<[a-z]*' "$st/logo.svg" | wc -l)" -le 3 ]; then bad "logo.svg looks like the scaffold placeholder"; fi
	[ "$QA" = 1 ] && { node "$ROOT/tools/previews/qa.js" "$t" || FAIL=1; }
done
[ "$FAIL" = 0 ] && echo "OK" || { echo "FAILED"; exit 1; }
