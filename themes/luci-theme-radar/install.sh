#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-radar root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-radar/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/radar" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-radar.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/radar
cp "$D/htdocs/luci-static/resources/view/radar/sysauth.js" /www/luci-static/resources/view/radar/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/radar" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Radar=/luci-static/radar
uci set luci.main.mediaurlbase=/luci-static/radar
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Radar installed. Hard-refresh the browser (Ctrl+Shift+R)."
