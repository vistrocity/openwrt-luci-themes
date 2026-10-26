#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-brutal root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-brutal/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/brutal" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-brutal.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/brutal
cp "$D/htdocs/luci-static/resources/view/brutal/sysauth.js" /www/luci-static/resources/view/brutal/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/brutal" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Neobrutalism=/luci-static/brutal
uci set luci.main.mediaurlbase=/luci-static/brutal
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Neobrutalism installed. Hard-refresh the browser (Ctrl+Shift+R)."
