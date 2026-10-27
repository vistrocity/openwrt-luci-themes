# luci-theme-obsidian

Dark LuCI theme with a teal accent, forked from luci-theme-bootstrap (Apache-2.0).
Dark-only: slate surfaces, rounded cards, glassy sticky header, teal buttons/progress bars.

## Install on a router (fastest)
    scp -O -r luci-theme-obsidian root@192.168.1.1:/tmp/
    ssh root@192.168.1.1 sh /tmp/luci-theme-obsidian/install.sh

Then hard-refresh the browser. To revert: System > System > Language and Style > pick another
theme, or `uci set luci.main.mediaurlbase=/luci-static/bootstrap && uci commit luci`.

## Build as a package
Place this folder at `feeds/luci/themes/luci-theme-obsidian`, then
`make menuconfig` (LuCI > Themes > luci-theme-obsidian) and `make package/luci-theme-obsidian/compile`.
On 25.12 the result is an `.apk`.

## Customise
All colours live in the "Obsidian overrides" block at the end of
`htdocs/luci-static/obsidian/cascade.css`. Change `--primary-color-*` and `--obsidian-glow`
(RGB triple) to re-accent the theme, and `--background-color-h/s/l` to shift the surfaces.
