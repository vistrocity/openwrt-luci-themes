# r/openwrt post for Fri 6 Nov (draft; check the sub's self-promotion rules first)

**Title:** Four more LuCI themes: Handheld (green LCD), Nixie, Subway, Chalkboard

**Body (markdown):**

Four new themes for the LuCI theme pack I posted last week. Each one is a full redesign rather than a recolour, and all keep forms and tables usable (focus states, contrast, phone width, reduced-motion).

- **Handheld**: four-shade green LCD, chunky mono text, keycap buttons that sink
- **Nixie**: glowing orange digits on dark brass, tube-style meters
- **Subway**: menu as coloured transit lines with station dots
- **Chalkboard**: slate with chalk lettering and hand-drawn boxes

Install one on the router (OpenWrt 25.12, tested on mediatek/filogic):

    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s subway

Repo (screenshots, all themes, how to revert): https://github.com/vistrocity/openwrt-luci-themes

Screenshots use mock data only. I built these with AI assistance (Claude); the CSS is plain and the repo is Apache-2.0. Feedback and theme ideas welcome.

**Screenshots to attach (docs/screenshots/):**

1. handheld-overview.jpg
2. handheld-settings.jpg
3. nixie-overview.jpg
4. nixie-settings.jpg
5. subway-overview.jpg
6. subway-settings.jpg
7. chalkboard-overview.jpg
8. chalkboard-settings.jpg
