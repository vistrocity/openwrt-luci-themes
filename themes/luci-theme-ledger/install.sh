#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-ledger root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-ledger/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/ledger" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-ledger.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/ledger
cp "$D/htdocs/luci-static/resources/view/ledger/sysauth.js" /www/luci-static/resources/view/ledger/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/ledger" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Ledger=/luci-static/ledger
uci set luci.main.mediaurlbase=/luci-static/ledger
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Ledger installed. Hard-refresh the browser (Ctrl+Shift+R)."
