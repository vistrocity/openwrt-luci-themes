#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-newsprint root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-newsprint/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/newsprint" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-newsprint.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/newsprint
cp "$D/htdocs/luci-static/resources/view/newsprint/sysauth.js" /www/luci-static/resources/view/newsprint/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/newsprint" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Newsprint=/luci-static/newsprint
uci set luci.main.mediaurlbase=/luci-static/newsprint
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Newsprint installed. Hard-refresh the browser (Ctrl+Shift+R)."
