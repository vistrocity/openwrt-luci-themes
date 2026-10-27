#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-terminal root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-terminal/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/terminal" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-terminal.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/terminal
cp "$D/htdocs/luci-static/resources/view/terminal/sysauth.js" /www/luci-static/resources/view/terminal/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/terminal" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Terminal=/luci-static/terminal
uci set luci.main.mediaurlbase=/luci-static/terminal
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Terminal installed. Hard-refresh the browser (Ctrl+Shift+R)."
