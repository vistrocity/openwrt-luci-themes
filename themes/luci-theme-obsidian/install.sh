#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-obsidian root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-obsidian/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/obsidian" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-obsidian.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/obsidian
cp "$D/htdocs/luci-static/resources/view/obsidian/sysauth.js" /www/luci-static/resources/view/obsidian/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/obsidian" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Obsidian=/luci-static/obsidian
uci set luci.main.mediaurlbase=/luci-static/obsidian
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Obsidian installed. Hard-refresh the browser (Ctrl+Shift+R)."
