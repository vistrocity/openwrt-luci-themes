# luci-theme-aquarium

Aquarium: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

- Deep teal gradient, translucent glass panels (blur where supported), aqua glow with coral highlights
- Slow, faint bubbles drift upwards behind the page; disabled under reduced motion
- Pill buttons, glowing meters

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s aquarium

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Aquarium overrides" at the end of `htdocs/luci-static/aquarium/cascade.css`; colours are the `--t-*` variables.
