# luci-theme-topo

Topo: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

- Sepia chart paper with faint contour rings in the background, double-ruled chart panels
- Compass rose beside the header clock; italic small-caps serif labels
- Sea-teal accent with a brick-red secondary

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s topo

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Topo overrides" at the end of `htdocs/luci-static/topo/cascade.css`; colours are the `--t-*` variables.
