# luci-theme-nixie

![Nixie overview](../../docs/screenshots/nixie-overview.jpg)

![Nixie settings page](../../docs/screenshots/nixie-settings.jpg)

Nixie: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

Glowing orange digits on dark brass: engraved plates with rivets, glass-tube meters, a flickering tube clock.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s nixie

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
