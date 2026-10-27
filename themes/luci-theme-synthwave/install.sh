#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-synthwave root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-synthwave/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/synthwave" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-synthwave.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/synthwave
cp "$D/htdocs/luci-static/resources/view/synthwave/sysauth.js" /www/luci-static/resources/view/synthwave/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/synthwave" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Synthwave=/luci-static/synthwave
uci set luci.main.mediaurlbase=/luci-static/synthwave
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Synthwave installed. Hard-refresh the browser (Ctrl+Shift+R)."
