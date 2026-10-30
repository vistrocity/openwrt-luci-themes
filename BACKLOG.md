# Theme backlog

One theme idea per line, in rough build order. Every theme must be a real redesign (layout feel, type,
shapes, texture, a distinct `logo.svg`), use no third-party brands, logos, characters or trademarks, respect
`prefers-reduced-motion`, stay readable at phone width, and keep forms and tables fully usable.

Workflow: `tools/new-theme.sh <slug> <Name>` -> edit CSS -> `tools/check-theme.sh <slug> --qa` ->
`tools/screenshots.sh <slug>` -> `tools/test-install.sh <slug>`.

**Rule:** when fewer than 8 ideas remain under "Queue", propose 8 more (under "Proposed") and ask for a go-ahead.

## Queue (not built yet)

| # | Slug | Idea |
|---|------|------|
| 1 | ledger | Green-bar accounting paper: tractor-feed edges, zebra rows, typewriter-ish mono, rubber-stamp status labels |
| 2 | bauhaus | Flat primaries, heavy geometric sans, hard grid, circles/squares/triangles as UI furniture |
| 3 | cockpit | Flight-instrument gauges in a night palette (red-free amber/green), round dials for meters, annunciator labels |
| 4 | cassette | Hi-fi deck: brushed metal, VU needle meters, tape-window panels, rocker-switch buttons |

## Proposed (waiting for a go-ahead; queue has only 4 left, so these are the next 8)

| # | Slug | Idea |
|---|------|------|
| 5 | radar | Phosphor sweep display: concentric range rings, green-on-black blips, sweep line that pauses under reduced motion |
| 6 | newsprint | Broadsheet front page: column rules, drop caps, condensed headline serif, halftone shading |
| 7 | typewriter | Manual typewriter on cream stock: ink-ribbon red/black, slab mono, slightly uneven baselines |
| 8 | pcb | Solder-green board: copper traces as borders, pad-shaped buttons, silkscreen labels |
| 9 | seismograph | Paper chart recorder: ruled chart grid, ink-pen traces for meters, pen-arm accents |
| 10 | apothecary | Pharmacy drawer labels: cream cartridge labels, ornate small caps, amber glass and cork tones |
| 11 | atomic | Mid-century modern: boomerang shapes, starbursts, teal/mustard/walnut, rounded geometric sans |
| 12 | observatory | Star-chart: deep indigo, constellation line work, brass dial rings, serif italics |

## Parked (revisit around end of Nov 2026, after a month of traffic)

**Minimal series:** CSS-only themes that try to do nothing extra. Stock bootstrap templates, no theme JS of their own
(reuse LuCI's menu script), no clock, no animation. `audit-theme.sh` would fail any minimal theme that ships a `.js`
file or inline `<script>`. Needs a `--minimal` option in `new-theme.sh`. Suggested by a r/openwrt commenter.
Possible first four: calm light, calm dark, high contrast, large text. Decide after seeing which themes get used.

## Built

Batch 1 (Fri 6 Nov 2026, tag `v2026.11.06`): handheld, nixie, subway, chalkboard.
Earlier (launch, Fri 30 Oct): the original 16.
