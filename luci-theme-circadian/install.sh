#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-circadian root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-circadian/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/circadian" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-circadian.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/circadian
cp "$D/htdocs/luci-static/resources/view/circadian/sysauth.js" /www/luci-static/resources/view/circadian/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/circadian" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Circadian=/luci-static/circadian
uci set luci.main.mediaurlbase=/luci-static/circadian
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Circadian installed. Hard-refresh the browser (Ctrl+Shift+R)."
