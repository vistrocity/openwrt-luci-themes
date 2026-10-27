# luci-theme-chalkboard

Chalkboard: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

Matte slate with chalk lettering: hand-drawn wobbly boxes, chalk-stroke meters, a wooden rail and ledge.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s chalkboard

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
