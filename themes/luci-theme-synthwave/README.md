# luci-theme-synthwave

Synthwave / outrun theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark-only.

- Purple-to-magenta dusk sky with a striped sun and a perspective grid floor on the horizon
- Translucent, blurred panels with neon pink outlines and purple inner glow
- Neon headings: italic, glowing, uppercase; cyan section labels; glowing glass header
- Save & Apply is a pink-to-amber gradient; Edit/Action cyan; Save violet; Delete/Reset hot red
- Progress bars use a pink > amber > cyan gradient with glow
- Falls back to more opaque panels without `backdrop-filter`

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s synthwave

Then hard-refresh the browser. Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Synthwave overrides" at the end of `htdocs/luci-static/synthwave/cascade.css`: the `--sw-*` palette,
`body` gradient for the sky, `body::before` for the sun and `body::after` for the grid floor.
