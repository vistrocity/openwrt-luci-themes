# luci-theme-sumie

Sumi-e: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

- Washi-paper background, ink-black serif type, tapering brush-stroke rules under headings
- Red hanko seal next to the hostname, faint enso ring in the corner, no boxes or shadows
- Outline buttons; Save & Apply is the red seal

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s sumie

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Sumi-e overrides" at the end of `htdocs/luci-static/sumie/cascade.css`; colours are the `--t-*` variables.
