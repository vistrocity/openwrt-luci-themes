#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-seismograph root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-seismograph/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/seismograph" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-seismograph.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/seismograph
cp "$D/htdocs/luci-static/resources/view/seismograph/sysauth.js" /www/luci-static/resources/view/seismograph/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/seismograph" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Seismograph=/luci-static/seismograph
uci set luci.main.mediaurlbase=/luci-static/seismograph
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Seismograph installed. Hard-refresh the browser (Ctrl+Shift+R)."
