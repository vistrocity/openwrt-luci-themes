#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-nixie root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-nixie/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/nixie" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-nixie.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/nixie
cp "$D/htdocs/luci-static/resources/view/nixie/sysauth.js" /www/luci-static/resources/view/nixie/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/nixie" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Nixie=/luci-static/nixie
uci set luci.main.mediaurlbase=/luci-static/nixie
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Nixie installed. Hard-refresh the browser (Ctrl+Shift+R)."
