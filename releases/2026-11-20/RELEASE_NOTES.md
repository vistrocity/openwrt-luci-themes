# v2026.11.20: Batch 3 (four new themes)

Batch 3 of the weekly Friday releases. Nothing existing was changed.

| Theme | Look | Mode |
|-------|------|------|
| **Radar** | A phosphor scope. The first theme with a **left sidebar menu**: a fixed rail with the scope brand, always-open `// GROUP` menus, bracketed panels, segmented meters and phosphor-key buttons. Below 900px the rail becomes a top bar with a slide-down menu. | Dark |
| **Newsprint** | A broadsheet front page. Masthead with double rules and stars, section tabs, headline serif, a drop cap on the page intro, column rules and halftone shading. | Light |
| **Typewriter** | Cream stock in the carriage. Monospace throughout, ink-ribbon black and red, bracketed keys, underscore fields, a blinking caret on the hostname. | Light |
| **PCB** | A solder-green board. Copper-edged panels with corner vias, silkscreen `U1 /` labels, gold pad meters and a connector strip under the header. | Dark |

## Install

    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s radar
    # or: newsprint | typewriter | pcb

Then hard-refresh the browser (Ctrl+Shift+R). Back to the default: System > System > Language and Style.

## Notes

- Radar's sidebar menu is CSS-only (a hidden checkbox and a label) with every group expanded, so on short screens the rail scrolls. No extra script is needed for the menu.
- All four respect `prefers-reduced-motion` (Radar's sweep and Typewriter's caret stop), have visible keyboard focus styles, and were checked at 390px width for horizontal overflow and text contrast.
- Newsprint and Typewriter use system fonts (Georgia / Didot, Courier), so lettering varies slightly by device.
- Each theme ships its own `logo.svg`, with no third-party brands or characters.
- Screenshots use mock data only.
