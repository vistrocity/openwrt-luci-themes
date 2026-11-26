#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-apothecary root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-apothecary/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/apothecary" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-apothecary.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/apothecary
cp "$D/htdocs/luci-static/resources/view/apothecary/sysauth.js" /www/luci-static/resources/view/apothecary/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/apothecary" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Apothecary=/luci-static/apothecary
uci set luci.main.mediaurlbase=/luci-static/apothecary
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Apothecary installed. Hard-refresh the browser (Ctrl+Shift+R)."
