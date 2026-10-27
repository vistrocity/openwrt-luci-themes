#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-__SLUG__ root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-__SLUG__/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/__SLUG__" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-__SLUG__.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/__SLUG__
cp "$D/htdocs/luci-static/resources/view/__SLUG__/sysauth.js" /www/luci-static/resources/view/__SLUG__/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/__SLUG__" /usr/share/ucode/luci/template/themes/
uci set luci.themes.__NAME__=/luci-static/__SLUG__
uci set luci.main.mediaurlbase=/luci-static/__SLUG__
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "__NAME__ installed. Hard-refresh the browser (Ctrl+Shift+R)."
