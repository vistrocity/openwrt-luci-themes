# openwrt-luci-themes

Custom LuCI themes for OpenWrt (tested target: OpenWrt 25.12, `mediatek/filogic`).

| Theme | Style | Folder |
|---|---|---|
| Obsidian | Dark slate + teal accent, rounded cards | [`luci-theme-obsidian`](luci-theme-obsidian) |
| Glass | Glassmorphism: frosted translucent cards on a violet/cyan gradient | [`luci-theme-glass`](luci-theme-glass) |
| Mission | Mission Control sci-fi HUD: amber/cyan, corner brackets, segmented meters, live clock | [`luci-theme-mission`](luci-theme-mission) |

Each theme folder is a self-contained LuCI package source tree with its own README
and a `install.sh` for dropping it onto a running router.

## Licence
Apache-2.0. The themes are derived from `luci-theme-bootstrap` from the
[OpenWrt LuCI project](https://github.com/openwrt/luci).
