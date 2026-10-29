#!/bin/sh
# Security audit for theme files: a theme's JavaScript and templates run in the browser with the
# logged-in admin's rights, so they must stay boring. Fails on network calls, dynamic code, storage,
# external URLs, unexpected script tags, downloads in per-theme shell scripts, and unexpected file types.
#
#   tools/audit-theme.sh <slug> [slug...]      or:  tools/audit-theme.sh --all
# This is a pattern scan, not a formal review. Run by tools/check-theme.sh for every theme.
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [ "${1:-}" = "--all" ]; then set -- $(ls "$ROOT/themes" | sed 's/^luci-theme-//'); fi
[ $# -ge 1 ] || { sed -n '2,8p' "$0"; exit 1; }
RC=0
for t in "$@"; do
	d="$ROOT/themes/luci-theme-$t"
	[ -d "$d" ] || { echo "audit $t: missing folder"; RC=1; continue; }
	python3 - "$d" "$t" <<'PY' || RC=1
import os, re, sys
d, t = sys.argv[1], sys.argv[2]
problems = []

JS_BAD = [
    (r'\bfetch\s*\(', 'fetch()'), (r'XMLHttpRequest', 'XMLHttpRequest'), (r'\beval\s*\(', 'eval()'),
    (r'new\s+Function\b', 'new Function'), (r'\bWebSocket\b', 'WebSocket'), (r'sendBeacon', 'sendBeacon'),
    (r'document\.cookie', 'document.cookie'), (r'\b(localStorage|sessionStorage|indexedDB)\b', 'browser storage'),
    (r'\bimportScripts\b|\bimport\s*\(', 'dynamic import'), (r'document\.write', 'document.write'),
    (r'\bnavigator\.(clipboard|geolocation|sendBeacon)', 'navigator API'), (r'\.src\s*=\s*[\'"]?https?:', 'script/img src set to a URL'),
]
HTML_BAD = [(r'<iframe', '<iframe>'), (r'<object|<embed', '<object>/<embed>'), (r'<form[^>]+action\s*=\s*["\']?https?:', 'form posting to a URL'),
            (r'<(link|img|source|video|audio)[^>]+(src|href)\s*=\s*["\']?(https?:)?//', 'external resource')]
CSS_BAD = [(r'@import', '@import'), (r'url\(\s*["\']?(https?:)?//', 'external url()'), (r'expression\s*\(', 'expression()'), (r'behavior\s*:', 'behavior:')]
SH_BAD = [(r'\b(wget|curl|nc|ncat|telnet|ssh|scp|ftp|tftp)\b', 'network tool'), (r'\beval\b', 'eval'), (r'\|\s*(ba)?sh\b', 'pipe to shell'),
          (r'base64\s+(-d|--decode)', 'base64 decode'), (r'\b(opkg|apk)\s+(install|add)\b', 'package install')]
ALLOWED_URL = re.compile(r'^https?://(www\.w3\.org|www\.apache\.org/licenses)')
# the stock LuCI script tags every theme carries (see luci-theme-bootstrap's header.ut / sysauth.ut)
SCRIPT_SRC_OK = [r"\{\{\s*asset\.src\s*\}\}", r"\{\{\s*resource\s*\}\}/cbi\.js", r"\{\{\s*dispatcher\.build_url\('admin/translations',\s*dispatcher\.lang\)\s*\}\}",
                 r"\{\{\s*resource\s*\}\}/[A-Za-z0-9_./-]+\.js"]
OK_EXT = {'.css', '.js', '.ut', '.svg', '.png', '.md', '.sh'}
OK_NAMES = {'Makefile', 'install.sh'}

def scan(path, rules, text, label):
    for rx, name in rules:
        if re.search(rx, text, re.I):
            problems.append('%s: %s' % (os.path.relpath(path, d), name))

for root, _, files in os.walk(d):
    for fn in files:
        p = os.path.join(root, fn); rel = os.path.relpath(p, d); ext = os.path.splitext(fn)[1]
        in_uci = '/etc/uci-defaults/' in p
        if ext not in OK_EXT and fn not in OK_NAMES and not in_uci:
            problems.append('unexpected file type: ' + rel); continue
        if ext == '.png': continue
        text = open(p, encoding='utf-8', errors='replace').read()
        if ext == '.js': scan(p, JS_BAD, text, 'js')
        if ext == '.ut':
            scan(p, HTML_BAD, text, 'html')
            for m in re.finditer(r'<script[^>]*>(.*?)</script>', text, re.S): scan(p, JS_BAD, m.group(1), 'inline js')
            for m in re.finditer(r'<script\b[^>]*\bsrc\s*=\s*"([^"]*)"', text):
                if not any(re.fullmatch(rx, m.group(1).strip()) for rx in SCRIPT_SRC_OK):
                    problems.append('%s: unexpected <script src="%s">' % (rel, m.group(1)))
        if ext == '.css': scan(p, CSS_BAD, text, 'css')
        if ext == '.sh' or in_uci or fn in OK_NAMES:
            scan(p, SH_BAD, '\n'.join(l for l in text.split('\n') if not l.lstrip().startswith('#')), 'sh')  # comments are not code
        if ext in ('.js', '.ut', '.css', '.sh') or in_uci or fn == 'Makefile':
            for u in re.findall(r'https?://[^\s"\'<>)]+', text):
                if ALLOWED_URL.match(u): continue
                if fn in ('README.md',): continue
                if fn == 'Makefile' and 'github.com/vistrocity' in u: continue
                if 'raw.githubusercontent.com/vistrocity/openwrt-luci-themes' in u: continue
                if 'github.com/openwrt/luci' in u or 'openwrt.org' in u: continue
                problems.append('%s: external URL %s' % (rel, u[:80]))
print('audit %s: %s' % (t, 'OK' if not problems else 'FAIL'))
for x in sorted(set(problems)): print('  ' + x)
sys.exit(1 if problems else 0)
PY
done
exit $RC
