#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-typewriter root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-typewriter/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/typewriter" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-typewriter.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/typewriter
cp "$D/htdocs/luci-static/resources/view/typewriter/sysauth.js" /www/luci-static/resources/view/typewriter/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/typewriter" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Typewriter=/luci-static/typewriter
uci set luci.main.mediaurlbase=/luci-static/typewriter
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Typewriter installed. Hard-refresh the browser (Ctrl+Shift+R)."
