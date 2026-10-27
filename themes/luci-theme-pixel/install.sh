#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-pixel root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-pixel/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/pixel" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-pixel.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/pixel
cp "$D/htdocs/luci-static/resources/view/pixel/sysauth.js" /www/luci-static/resources/view/pixel/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/pixel" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Pixel=/luci-static/pixel
uci set luci.main.mediaurlbase=/luci-static/pixel
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Pixel installed. Hard-refresh the browser (Ctrl+Shift+R)."
