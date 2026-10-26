#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-paper root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-paper/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/paper" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-paper.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/paper
cp "$D/htdocs/luci-static/resources/view/paper/sysauth.js" /www/luci-static/resources/view/paper/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/paper" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Paper=/luci-static/paper
uci set luci.main.mediaurlbase=/luci-static/paper
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Paper installed. Hard-refresh the browser (Ctrl+Shift+R)."
