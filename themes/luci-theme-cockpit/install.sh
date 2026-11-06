#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-cockpit root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-cockpit/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/cockpit" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-cockpit.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/cockpit
cp "$D/htdocs/luci-static/resources/view/cockpit/sysauth.js" /www/luci-static/resources/view/cockpit/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/cockpit" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Cockpit=/luci-static/cockpit
uci set luci.main.mediaurlbase=/luci-static/cockpit
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Cockpit installed. Hard-refresh the browser (Ctrl+Shift+R)."
