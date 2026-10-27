# luci-theme-handheld

Handheld: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

Four-shade green LCD in a dark casing: chunky pixel-style text, dithered title bars, keycap buttons that sink.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s handheld

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
