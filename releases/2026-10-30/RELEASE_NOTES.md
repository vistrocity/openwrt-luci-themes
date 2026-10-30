# v2026.10.30: Batch 1 (four new themes)

Batch 1 of the weekly Friday releases. Nothing existing was changed.

| Theme | Look | Mode |
|-------|------|------|
| **Handheld** | Four-shade green LCD in a dark casing. Chunky monospace text, dithered title bars, square keycap buttons that sink when pressed, dashed alerts. Uses exactly four greens. | Light |
| **Nixie** | Glowing orange digits on dark brass. Engraved brass plates with rivets, glass-tube meters with a glowing filament, a flickering tube clock. | Dark |
| **Subway** | A transit map. The top menu is a set of coloured lines with station dots, sections hang off a route line, meters end in a station dot. | Light |
| **Chalkboard** | Matte slate with chalk lettering. Hand-drawn wobbly boxes, chalk-stroke meters, a wooden rail and ledge. | Dark |

## Install

    wget -qO- https://raw.githubusercontent.com/vistrocity/openwrt-luci-themes/main/install.sh | sh -s handheld
    # or: nixie | subway | chalkboard

Then hard-refresh the browser (Ctrl+Shift+R). Back to the default: System > System > Language and Style.

## Notes

- All four respect `prefers-reduced-motion` (Nixie's tube flicker stops), have visible keyboard focus styles, and were checked at 390px width for horizontal overflow.
- Chalkboard's lettering uses the system handwriting font (Segoe Print, Bradley Hand, Chalkboard SE, Comic Neue or the generic `cursive`), so it looks different per device. Body text stays a normal sans for readability.
- Tooling: `tools/new-theme.sh`, `tools/screenshots.sh`, `tools/check-theme.sh`, `tools/test-install.sh`; `install.sh` gained `REF=`, `OWT_TARBALL=` and `GITHUB_TOKEN=` options. README gallery and counts are generated from `tools/themes.tsv`.
- Screenshots use mock data only.

Release steps (done): merge `release/2026-11-06` into `main`, then tag `v2026.10.30` and create the GitHub release from this file.