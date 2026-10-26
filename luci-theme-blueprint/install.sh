#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-blueprint root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-blueprint/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/blueprint" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-blueprint.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/blueprint
cp "$D/htdocs/luci-static/resources/view/blueprint/sysauth.js" /www/luci-static/resources/view/blueprint/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/blueprint" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Blueprint=/luci-static/blueprint
uci set luci.main.mediaurlbase=/luci-static/blueprint
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Blueprint installed. Hard-refresh the browser (Ctrl+Shift+R)."
