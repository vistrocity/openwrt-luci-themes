# luci-theme-observatory

![Observatory overview](../../docs/screenshots/observatory-overview.jpg)

![Observatory settings page](../../docs/screenshots/observatory-settings.jpg)

Observatory: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

Star chart under the dome: deep indigo sky, brass dial rings, constellation line work and serif italics

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s observatory

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
