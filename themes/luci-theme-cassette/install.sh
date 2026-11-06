#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-cassette root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-cassette/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/cassette" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-cassette.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/cassette
cp "$D/htdocs/luci-static/resources/view/cassette/sysauth.js" /www/luci-static/resources/view/cassette/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/cassette" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Cassette=/luci-static/cassette
uci set luci.main.mediaurlbase=/luci-static/cassette
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Cassette installed. Hard-refresh the browser (Ctrl+Shift+R)."
