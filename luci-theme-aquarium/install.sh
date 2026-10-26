#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-aquarium root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-aquarium/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/aquarium" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-aquarium.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/aquarium
cp "$D/htdocs/luci-static/resources/view/aquarium/sysauth.js" /www/luci-static/resources/view/aquarium/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/aquarium" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Aquarium=/luci-static/aquarium
uci set luci.main.mediaurlbase=/luci-static/aquarium
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Aquarium installed. Hard-refresh the browser (Ctrl+Shift+R)."
