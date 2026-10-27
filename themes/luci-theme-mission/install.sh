#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-mission root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-mission/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/mission" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-mission.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/mission
cp "$D/htdocs/luci-static/resources/view/mission/sysauth.js" /www/luci-static/resources/view/mission/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/mission" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Mission=/luci-static/mission
uci set luci.main.mediaurlbase=/luci-static/mission
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Mission installed. Hard-refresh the browser (Ctrl+Shift+R)."
