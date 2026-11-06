# luci-theme-bauhaus

![Bauhaus overview](../../docs/screenshots/bauhaus-overview.jpg)

![Bauhaus settings page](../../docs/screenshots/bauhaus-settings.jpg)

Bauhaus: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

Flat primaries on warm paper: heavy geometric type, a hard grid, black frames and circle, square and triangle markers.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s bauhaus

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
