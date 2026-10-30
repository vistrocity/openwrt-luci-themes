#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-handheld root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-handheld/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/handheld" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-handheld.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/handheld
cp "$D/htdocs/luci-static/resources/view/handheld/sysauth.js" /www/luci-static/resources/view/handheld/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/handheld" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Handheld=/luci-static/handheld
uci set luci.main.mediaurlbase=/luci-static/handheld
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Handheld installed. Hard-refresh the browser (Ctrl+Shift+R)."
