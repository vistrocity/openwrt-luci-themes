#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-teletext root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-teletext/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/teletext" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-teletext.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/teletext
cp "$D/htdocs/luci-static/resources/view/teletext/sysauth.js" /www/luci-static/resources/view/teletext/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/teletext" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Teletext=/luci-static/teletext
uci set luci.main.mediaurlbase=/luci-static/teletext
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Teletext installed. Hard-refresh the browser (Ctrl+Shift+R)."
