# openwrt-luci-themes

Custom LuCI themes for OpenWrt (tested target: OpenWrt 25.12, `mediatek/filogic`).

| Theme | Style | Folder |
|---|---|---|
| Obsidian | Dark slate + teal accent, rounded cards | [`luci-theme-obsidian`](luci-theme-obsidian) |
| Glass | Glassmorphism: frosted translucent cards on a violet/cyan gradient | [`luci-theme-glass`](luci-theme-glass) |
| Mission | Mission Control sci-fi HUD: amber/cyan, corner brackets, segmented meters, live clock | [`luci-theme-mission`](luci-theme-mission) |
| Blueprint | Technical drawing: white linework on blueprint blue, drafting grid, hatched meters, FIG. numbering | [`luci-theme-blueprint`](luci-theme-blueprint) |
| Terminal | Green-phosphor CRT: scanlines, `root@host:~#` prompt, `[ bracketed ]` buttons | [`luci-theme-terminal`](luci-theme-terminal) |
| Neobrutalism | Light: cream paper, thick black outlines, hard shadows, buttons that press down | [`luci-theme-brutal`](luci-theme-brutal) |
| Synthwave | Neon outrun: striped sun, perspective grid floor, glowing glass panels | [`luci-theme-synthwave`](luci-theme-synthwave) |
| Paper | Light: e-ink / printed page, book serif, hairline rules, one red accent | [`luci-theme-paper`](luci-theme-paper) |
| Retro | Light: 90s desktop, bevelled windows, navy title bars, blue-block meters | [`luci-theme-retro`](luci-theme-retro) |
| Rack | Dark: server-rack faceplates, mounting ears, 1U/2U labels, status LEDs | [`luci-theme-rack`](luci-theme-rack) |
| Circadian | Palette follows local time: dawn, day, dusk, night (stars) | [`luci-theme-circadian`](luci-theme-circadian) |
| Teletext | Dark: 80s TV text, eight colours, block bars | [`luci-theme-teletext`](luci-theme-teletext) |
| Pixel (8-bit) | Dark: pixel-RPG menus, notched borders, health-bar meters | [`luci-theme-pixel`](luci-theme-pixel) |
| Aquarium | Dark: deep-sea gradient, glass panels, rising bubbles | [`luci-theme-aquarium`](luci-theme-aquarium) |
| Sumie (sumi-e) | Light: washi paper, brush-stroke rules, red seal | [`luci-theme-sumie`](luci-theme-sumie) |
| Topo | Light: sepia sea-chart, contour rings, compass rose | [`luci-theme-topo`](luci-theme-topo) |

Each theme folder is a self-contained LuCI package source tree with its own README
and a `install.sh` for dropping it onto a running router.

## Licence
Apache-2.0. The themes are derived from `luci-theme-bootstrap` from the
[OpenWrt LuCI project](https://github.com/openwrt/luci).

## Install straight from GitHub (on the router)
    export GITHUB_TOKEN=github_pat_xxx   # only needed while the repo is private (read-only, Contents: read)
    wget -qO- --header="Authorization: Bearer $GITHUB_TOKEN" \
      https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s mission

If the repo is public, drop the token and the `--header` line. Replace `mission` with any theme name: `obsidian`, `glass`, `mission`, `blueprint`, `terminal`, `brutal`, `synthwave`, `paper`, `retro`, `rack`, `circadian`, `teletext`, `pixel`, `aquarium`, `sumie` or `topo`.
