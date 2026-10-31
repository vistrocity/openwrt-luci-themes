# luci-theme-retro

![Retro overview](../../docs/screenshots/retro-overview.jpg)

![Retro settings page](../../docs/screenshots/retro-settings.jpg)

Retro: a 90s desktop theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0). Light theme.
Original styling only: no logos, icons or fonts from any operating system are used.

- Teal desktop, grey bevelled "windows", navy gradient title bars for each section
- Taskbar header with a raised brand button, raised/sunken navigation and a clock in the "tray"
- Raised buttons that press in, sunken text fields, list-view tables with a navy selection highlight
- Blue-block progress bars, tooltip-yellow alerts, classic raised tabs, status-bar footer
- Save & Apply is the bold default button (extra black outline)

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s retro

Then hard-refresh the browser. Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Retro overrides" at the end of `htdocs/luci-static/retro/cascade.css`: `--r-desktop` (desktop colour),
`--r-face` (window grey) and `--r-title` (title-bar gradient).
