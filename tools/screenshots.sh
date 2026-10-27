#!/bin/sh
# Render the two public screenshots per theme (overview with the Network menu open, and a settings page)
# in headless Chromium from the mock pages. Mock data only; nothing is read from a router.
#
#   tools/screenshots.sh              all themes
#   tools/screenshots.sh rack topo    just these
# Output: docs/screenshots/<theme>-{overview,settings}.jpg (Circadian also gets dawn/day/night variants).
# Needs: node and `npm i playwright` (run from anywhere; NODE_PATH is set for you if playwright is installed globally).
set -e
D="$(cd "$(dirname "$0")" && pwd)"
exec node "$D/previews/make-previews.js" "$@"
