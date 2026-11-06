# luci-theme-cockpit

![Cockpit overview](../../docs/screenshots/cockpit-overview.jpg)

![Cockpit settings page](../../docs/screenshots/cockpit-settings.jpg)

Cockpit: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Dark theme.

Night-flight instrument panel: black glass, amber and green glow, bezel frames with screws, annunciator labels and tape gauges.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s cockpit

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
