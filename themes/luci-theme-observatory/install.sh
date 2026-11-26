#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-observatory root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-observatory/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/observatory" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-observatory.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/observatory
cp "$D/htdocs/luci-static/resources/view/observatory/sysauth.js" /www/luci-static/resources/view/observatory/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/observatory" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Observatory=/luci-static/observatory
uci set luci.main.mediaurlbase=/luci-static/observatory
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Observatory installed. Hard-refresh the browser (Ctrl+Shift+R)."
