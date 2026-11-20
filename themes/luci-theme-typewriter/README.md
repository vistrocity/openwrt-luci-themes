# luci-theme-typewriter

![Typewriter overview](../../docs/screenshots/typewriter-overview.jpg)

![Typewriter settings page](../../docs/screenshots/typewriter-settings.jpg)

Typewriter: a custom theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.

Cream stock in the carriage: monospace throughout, ink-ribbon black and red, bracketed keys, underscore fields and a blinking caret.

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s typewriter

Then hard-refresh the browser (Ctrl+Shift+R). Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.
