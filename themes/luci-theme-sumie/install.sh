#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-sumie root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-sumie/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/sumie" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-sumie.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/sumie
cp "$D/htdocs/luci-static/resources/view/sumie/sysauth.js" /www/luci-static/resources/view/sumie/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/sumie" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Sumie=/luci-static/sumie
uci set luci.main.mediaurlbase=/luci-static/sumie
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Sumie installed. Hard-refresh the browser (Ctrl+Shift+R)."
