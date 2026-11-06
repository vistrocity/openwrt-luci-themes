# Theme backlog

One theme idea per line, in rough build order. Every theme must be a real redesign (layout feel, type,
shapes, texture, a distinct `logo.svg`), use no third-party brands, logos, characters or trademarks, respect
`prefers-reduced-motion`, stay readable at phone width, and keep forms and tables fully usable.

Workflow: `tools/new-theme.sh <slug> <Name>` -> edit CSS -> `tools/check-theme.sh <slug> --qa` ->
`tools/screenshots.sh <slug>` -> `tools/test-install.sh <slug>`.

**Rule:** when fewer than 8 ideas remain under "Queue", propose 8 more (under "Proposed") and ask for a go-ahead.

## Queue (not built yet)

Empty. The next batch comes from the Proposed ideas below once approved.

## Proposed (waiting for a go-ahead; these are the next 8)

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

## Batch 3 note (Fri 13 Nov 2026)

One of the four should be the first theme with a **sidebar layout**: a left menu rail that collapses into a
slide-out drawer at phone width. CSS plus a short menu script (about 100-150 lines for opening and closing
submenus). No single-page navigation and nothing that loads or runs LuCI view modules itself, so it still
passes `audit-theme.sh`. Candidates from the list below: radar, pcb, observatory. Decide when Batch 2 ships.

## Parked (revisit around end of Nov 2026, after a month of traffic)

**Minimal series:** CSS-only themes that try to do nothing extra. Stock bootstrap templates, no theme JS of their own
(reuse LuCI's menu script), no clock, no animation. `audit-theme.sh` would fail any minimal theme that ships a `.js`
file or inline `<script>`. Needs a `--minimal` option in `new-theme.sh`. Suggested by a r/openwrt commenter.
Possible first four: calm light, calm dark, high contrast, large text. Decide after seeing which themes get used.

## Built

Batch 1 (Fri 30 Oct 2026, tag `v2026.10.30`): handheld, nixie, subway, chalkboard.
Batch 2 (Fri 6 Nov 2026, tag `v2026.11.06`): ledger, bauhaus, cockpit, cassette.
Launch (Tue 27 Oct): the original 16.
