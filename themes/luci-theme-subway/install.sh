#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-subway root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-subway/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/subway" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-subway.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/subway
cp "$D/htdocs/luci-static/resources/view/subway/sysauth.js" /www/luci-static/resources/view/subway/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/subway" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Subway=/luci-static/subway
uci set luci.main.mediaurlbase=/luci-static/subway
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Subway installed. Hard-refresh the browser (Ctrl+Shift+R)."
