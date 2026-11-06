# luci-theme-ledger

![Ledger overview](../../docs/screenshots/ledger-overview.jpg)

![Ledger settings page](../../docs/screenshots/ledger-settings.jpg)

Ledger: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

Green-bar accounting paper: tractor-feed edges, ruled columns, typewriter type and rubber-stamp labels.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s ledger

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
