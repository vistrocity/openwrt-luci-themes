# Theme backlog

One theme idea per line, in rough build order. Every theme must be a real redesign (layout feel, type,
shapes, texture, a distinct `logo.svg`), use no third-party brands, logos, characters or trademarks, respect
`prefers-reduced-motion`, stay readable at phone width, and keep forms and tables fully usable.

Workflow: `tools/new-theme.sh <slug> <Name>` -> edit CSS -> `tools/check-theme.sh <slug> --qa` ->
`tools/screenshots.sh <slug>` -> `tools/test-install.sh <slug>`.

**Rule:** when fewer than 8 ideas remain under "Proposed", add 8 more ideas (distinct looks, no brands) in the same PR as the batch.

## Queue (not built yet)

Empty. The next batch comes from the Proposed ideas below once approved.

## Proposed (waiting for a go-ahead; build in this order, 4 per Friday)

| # | Slug | Idea |
|---|------|------|
| 9 | seismograph | Paper chart recorder: ruled chart grid, ink-pen traces for meters, pen-arm accents |
| 10 | apothecary | Pharmacy drawer labels: cream cartridge labels, ornate small caps, amber glass and cork tones |
| 11 | atomic | Mid-century modern: boomerang shapes, starbursts, teal/mustard/walnut, rounded geometric sans |
| 12 | observatory | Star-chart: deep indigo, constellation line work, brass dial rings, serif italics |
| 13 | blueprint | Architect's blueprint: cyan paper, white drafting lines, dimension arrows, title-block footer |
| 14 | terrazzo | Speckled terrazzo floor: pastel chips, rounded slabs, chunky soft shadows |
| 15 | lighthouse | Coastal navy and white stripes, rope borders, brass lamp accents, lifebuoy-style badges |
| 16 | botanical | Herbarium plates: pressed-leaf line art, sage and ivory, italic Latin-style labels |
| 17 | arcade | Cabinet marquee: dark purple, neon tube outlines, chunky pixel-style headings (original art only) |
| 18 | letterpress | Deep-debossed ivory card, single-colour ink, ornamental rules, wide-tracked caps |
| 19 | tidepool | Soft aqua gradients, rounded pebble cards, wave-edge dividers, calm low contrast-safe palette |
| 20 | brutalist | Raw concrete greys, oversized mono type, hard offsets, hazard-stripe accents |

## Parked (revisit around end of Nov 2026, after a month of traffic)

**Minimal series:** CSS-only themes that try to do nothing extra. Stock bootstrap templates, no theme JS of their own
(reuse LuCI's menu script), no clock, no animation. `audit-theme.sh` would fail any minimal theme that ships a `.js`
file or inline `<script>`. Needs a `--minimal` option in `new-theme.sh`. Suggested by a r/openwrt commenter.
Possible first four: calm light, calm dark, high contrast, large text. Decide after seeing which themes get used.

## Built

Batch 1 (Fri 30 Oct 2026, tag `v2026.10.30`): handheld, nixie, subway, chalkboard.
Batch 2 (Fri 6 Nov 2026, tag `v2026.11.06`): ledger, bauhaus, cockpit, cassette.
Batch 3 (Fri 20 Nov 2026, tag `v2026.11.20`): radar (first sidebar layout), newsprint, typewriter, pcb.
Launch (Tue 27 Oct): the original 16.
