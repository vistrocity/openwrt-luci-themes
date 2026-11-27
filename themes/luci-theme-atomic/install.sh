#!/bin/sh
# Quick install on a running OpenWrt router (no build needed).
# Usage: copy this folder to the router (scp -O -r luci-theme-atomic root@192.168.1.1:/tmp/)
#        then:  sh /tmp/luci-theme-atomic/install.sh
set -e
D="$(cd "$(dirname "$0")" && pwd)"
cp -r "$D/htdocs/luci-static/atomic" /www/luci-static/
cp "$D/htdocs/luci-static/resources/menu-atomic.js" /www/luci-static/resources/
mkdir -p /www/luci-static/resources/view/atomic
cp "$D/htdocs/luci-static/resources/view/atomic/sysauth.js" /www/luci-static/resources/view/atomic/
mkdir -p /usr/share/ucode/luci/template/themes
cp -r "$D/ucode/template/themes/atomic" /usr/share/ucode/luci/template/themes/
uci set luci.themes.Atomic=/luci-static/atomic
uci set luci.main.mediaurlbase=/luci-static/atomic
uci commit luci
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache 2>/dev/null || true
echo "Atomic installed. Hard-refresh the browser (Ctrl+Shift+R)."
