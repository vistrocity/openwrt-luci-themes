# luci-theme-atomic

![Atomic overview](../../docs/screenshots/atomic-overview.jpg)

![Atomic settings page](../../docs/screenshots/atomic-settings.jpg)

Atomic: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

Mid-century modern: boomerang-cut cards, starburst bullets, teal, mustard and walnut on warm cream

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s atomic

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
