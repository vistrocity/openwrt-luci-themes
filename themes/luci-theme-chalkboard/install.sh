#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-chalkboard root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-chalkboard/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/chalkboard" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-chalkboard.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/chalkboard
cp "$D/htdocs/luci-static/resources/view/chalkboard/sysauth.js" /www/luci-static/resources/view/chalkboard/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/chalkboard" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Chalkboard=/luci-static/chalkboard
uci set luci.main.mediaurlbase=/luci-static/chalkboard
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Chalkboard installed. Hard-refresh the browser (Ctrl+Shift+R)."
