#!/bin/sh
# Scaffold a new theme from the bootstrap base and register it everywhere.
#
#   tools/new-theme.sh <slug> <Name> [--light] [--color '#rrggbb'] [--tag 'gallery blurb'] [--title 'Package title']
#
# Creates luci-theme-<slug>/ (templates, menu, login view, installer, starter cascade.css with the
# shared accessibility baseline), appends it to tools/themes.tsv, then runs `new-theme.sh --sync`:
# top-level install.sh list, README gallery, theme count in the headline and badge, name list.
# <Name> is the uci key (luci.themes.<Name>): letters and digits only, no '-' or spaces.
#   tools/new-theme.sh --sync     re-run just the registration step
set -e
D="$(cd "$(dirname "$0")" && pwd)"
if [ "$1" = "--sync" ]; then exec python3 "$D/lib/scaffold.py" sync; fi
[ $# -ge 2 ] || { sed -n '2,12p' "$0"; exit 1; }
exec python3 "$D/lib/scaffold.py" new "$@"
