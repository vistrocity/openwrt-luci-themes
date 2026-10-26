#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-retro root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-retro/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/retro" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-retro.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/retro
cp "$D/htdocs/luci-static/resources/view/retro/sysauth.js" /www/luci-static/resources/view/retro/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/retro" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Retro=/luci-static/retro
uci set luci.main.mediaurlbase=/luci-static/retro
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Retro installed. Hard-refresh the browser (Ctrl+Shift+R)."
