# v2026.11.06: Batch 2 (four new themes)

Batch 2 of the weekly Friday releases. Nothing existing was changed.

| Theme | Look | Mode |
|-------|------|------|
| **Ledger** | Green-bar accounting paper. Tractor-feed holes down both edges, green and white bands, ruled columns, typewriter type, rubber-stamp status labels and double-ruled buttons. | Light |
| **Bauhaus** | Flat primaries on warm paper. Heavy geometric type, a hard grid, black frames, a circle, square or triangle on every section heading, no shadows or gradients. | Light |
| **Cockpit** | A night-flight instrument panel. Black glass, amber and green glow, bezel frames with corner screws, annunciator-style labels and round dial meters with a needle. | Dark |
| **Cassette** | A hi-fi tape deck. Brushed-metal faceplate, a tape window with two reels on every panel, VU-scale meters with a red zone and needle, rocker-switch buttons. | Dark |

## Install

    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s ledger
    # or: bauhaus | cockpit | cassette

Then hard-refresh the browser (Ctrl+Shift+R). Back to the default: System > System > Language and Style.

## Notes

- All four respect `prefers-reduced-motion` (Cockpit's lamp pulse stops), have visible keyboard focus styles, and were checked at 390px width for horizontal overflow and text contrast.
- Cockpit's round dials use one short inline script in the footer. It copies each meter's width into a CSS variable (`--v`) and the CSS draws the arc and needle. It makes no network calls, uses no storage, and passes `tools/audit-theme.sh`. Meters inside tables stay as tape gauges.
- Ledger and Cassette use system fonts (Courier New, Helvetica), so the lettering varies slightly by device.
- Each theme ships its own `logo.svg`, with no third-party brands or characters.
- Screenshots use mock data only.
