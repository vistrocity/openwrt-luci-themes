# openwrt-luci-themes

Custom LuCI themes for OpenWrt (tested target: OpenWrt 25.12, `mediatek/filogic`).

| Theme | Style | Folder |
|---|---|---|
| Obsidian | Dark slate + teal accent, rounded cards | [`luci-theme-obsidian`](luci-theme-obsidian) |
| Glass | Glassmorphism: frosted translucent cards on a violet/cyan gradient | [`luci-theme-glass`](luci-theme-glass) |
| Mission | Mission Control sci-fi HUD: amber/cyan, corner brackets, segmented meters, live clock | [`luci-theme-mission`](luci-theme-mission) |
| Blueprint | Technical drawing: white linework on blueprint blue, drafting grid, hatched meters, FIG. numbering | [`luci-theme-blueprint`](luci-theme-blueprint) |

Each theme folder is a self-contained LuCI package source tree with its own README
and a `install.sh` for dropping it onto a running router.

## Licence
Apache-2.0. The themes are derived from `luci-theme-bootstrap` from the
[OpenWrt LuCI project](https://github.com/openwrt/luci).

## Install straight from GitHub (on the router)
    export GITHUB_TOKEN=github_pat_xxx   # only needed while the repo is private (read-only, Contents: read)
    wget -qO- --header="Authorization: Bearer $GITHUB_TOKEN" \
      https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s mission

If the repo is public, drop the token and the `--header` line. Replace `mission` with `glass`, `obsidian` or `blueprint`.
