# luci-theme-newsprint

![Newsprint overview](../../docs/screenshots/newsprint-overview.jpg)

![Newsprint settings page](../../docs/screenshots/newsprint-settings.jpg)

Newsprint: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

A broadsheet front page: masthead with double rules, section tabs, headline serif, drop caps, column rules and halftone shading.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s newsprint

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
