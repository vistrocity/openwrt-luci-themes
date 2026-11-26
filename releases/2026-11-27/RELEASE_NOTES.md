# v2026.11.27: Batch 4 (four new themes)

Batch 4 of the weekly Friday releases. Nothing existing was changed.

| Theme | Look | Mode |
|-------|------|------|
| **Seismograph** | A paper chart recorder. Ruled red-grid chart paper, a time-scale ruler down the left edge of the page, a pen-arm marker on every heading, and meters drawn as ink-pen hatching. Dark metal top plate. | Light |
| **Apothecary** | Pharmacy drawers and labels. A walnut drawer front with a brass pull, cream cartridge-label sections with double rules and small caps, cork-textured counter and amber glass vial meters. | Light |
| **Atomic** | Mid-century modern. Teal band with a mustard sunburst, boomerang-cut cards on a mustard offset slab, starburst bullets, pill-shaped fields and a rounded geometric sans. | Light |
| **Observatory** | A star chart under the dome. Deep indigo sky with scattered stars, brass dial rings, hairline-framed panels, constellation-style menu marks and serif italics. | Dark |

## Install

    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s seismograph
    # or: apothecary | atomic | observatory

Then hard-refresh the browser (Ctrl+Shift+R). Back to the default: System > System > Language and Style.

## Notes

- All four respect `prefers-reduced-motion`, have visible keyboard focus styles, and were checked at 390px width for horizontal overflow and text contrast.
- Apothecary, Observatory and Seismograph rely on system fonts (Baskerville / Palatino / Georgia, Gill Sans / Trebuchet), so lettering varies slightly by device.
- Textures are pure CSS gradients; no images or scripts are added.
- Each theme ships its own `logo.svg`, with no third-party brands or characters.
- Screenshots use mock data only.
