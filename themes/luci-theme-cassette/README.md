# luci-theme-cassette

![Cassette overview](../../docs/screenshots/cassette-overview.jpg)

![Cassette settings page](../../docs/screenshots/cassette-settings.jpg)

Cassette: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

A hi-fi tape deck: brushed metal, a tape window on every panel, VU-scale meters with a needle and rocker-switch buttons.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s cassette

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
