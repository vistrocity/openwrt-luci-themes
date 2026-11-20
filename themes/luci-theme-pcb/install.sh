#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-pcb root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-pcb/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/pcb" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-pcb.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/pcb
cp "$D/htdocs/luci-static/resources/view/pcb/sysauth.js" /www/luci-static/resources/view/pcb/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/pcb" /usr/share/ucode/luci/template/themes/
uci set luci.themes.PCB=/luci-static/pcb
uci set luci.main.mediaurlbase=/luci-static/pcb
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "PCB installed. Hard-refresh the browser (Ctrl+Shift+R)."
