#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-rack root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-rack/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/rack" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-rack.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/rack
cp "$D/htdocs/luci-static/resources/view/rack/sysauth.js" /www/luci-static/resources/view/rack/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/rack" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Rack=/luci-static/rack
uci set luci.main.mediaurlbase=/luci-static/rack
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Rack installed. Hard-refresh the browser (Ctrl+Shift+R)."
