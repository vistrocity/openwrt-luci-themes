# luci-theme-teletext

Teletext: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

- Pure black with the eight teletext colours; blue/cyan title bars and block-graphic dividers
- Monospace capitals, solid colour-block buttons (green Save & Apply)
- Header clock reads like a teletext page header: `P100 MON 26 12:00/05`

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s teletext

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Teletext overrides" at the end of `htdocs/luci-static/teletext/cascade.css`; colours are the `--t-*` variables.
