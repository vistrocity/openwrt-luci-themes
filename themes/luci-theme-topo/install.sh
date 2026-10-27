#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-topo root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-topo/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/topo" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-topo.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/topo
cp "$D/htdocs/luci-static/resources/view/topo/sysauth.js" /www/luci-static/resources/view/topo/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/topo" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Topo=/luci-static/topo
uci set luci.main.mediaurlbase=/luci-static/topo
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Topo installed. Hard-refresh the browser (Ctrl+Shift+R)."
