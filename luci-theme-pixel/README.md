# luci-theme-pixel

8-bit: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

- Game-menu windows with notched pixel borders on deep purple; gold and green accents
- Health-bar style segmented meters, ▶ cursor on the active menu entry
- Footer shows a blinking PRESS START (stops under reduced motion)

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s pixel

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"8-bit overrides" at the end of `htdocs/luci-static/pixel/cascade.css`; colours are the `--t-*` variables.
