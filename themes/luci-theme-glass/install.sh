#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-glass root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-glass/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/glass" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-glass.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/glass
cp "$D/htdocs/luci-static/resources/view/glass/sysauth.js" /www/luci-static/resources/view/glass/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/glass" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Glass=/luci-static/glass
uci set luci.main.mediaurlbase=/luci-static/glass
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Glass installed. Hard-refresh the browser (Ctrl+Shift+R)."
