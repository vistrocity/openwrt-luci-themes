# luci-theme-terminal

Terminal: a green-phosphor CRT theme for LuCI, forked from luci-theme-bootstrap (Apache-2.0).

- Black screen, glowing green monospace text, scanline + vignette overlay (never blocks clicks)
- Header is a shell prompt, `root@<hostname>:~#`, with a blinking block cursor
- Buttons render as `[ LABEL ]`; hover inverts to a solid green block
- Save & Apply is the always-inverted button; Delete/Reset are red
- Segmented dotted meters, dashed rules, `$` / `>` markers on titles, `[hh:mm:ss]`-style clock
- Dark-only. Animations (cursor, flicker) switch off under "reduce motion".

## Install on a router
    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s terminal

Then hard-refresh the browser. Revert: System > System > Language and Style, or
`uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Customise
"Terminal overrides" at the end of `htdocs/luci-static/terminal/cascade.css`: `--t-fg` / `--t-fg-rgb`
(swap for amber `#ffb000` / `255, 176, 0` for an amber monitor), and the `body::after` overlay for scanlines.
