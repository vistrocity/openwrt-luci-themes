# Batch 2 plan (ships Fri 6 Nov 2026)

Four themes from the backlog. Each is a real redesign with its own logo; none uses third-party brands or characters.
Rules as always: reduced-motion respected, readable at phone width, forms and tables fully usable, mock data only in screenshots.

| Slug | Name | Mode | Look |
|------|------|------|------|
| ledger | Ledger | Light | Green-bar accounting paper: pale green and white row bands, tractor-feed edge holes, typewriter-style mono, rubber-stamp status labels, ruled columns |
| bauhaus | Bauhaus | Light | Flat primaries (red, yellow, blue) on off-white, heavy geometric sans, hard grid, circle/square/triangle shapes as buttons and markers, no shadows or gradients |
| cockpit | Cockpit | Dark | Night-flight instrument panel: black panel, amber and green glow (no bright white), round dial meters, annunciator-style status labels, bezel-framed sections |
| cassette | Cassette | Dark | Hi-fi deck: brushed-metal bars, a tape-window panel for headings, VU-needle meters, rocker-switch buttons, engraved labels |

## Notes

- Light/dark balance: two of each.
- Order of work: ledger, bauhaus, cockpit, cassette. Each goes through `tools/new-theme.sh`, `tools/check-theme.sh --qa`
  (includes the code audit), `tools/screenshots.sh`, `tools/test-install.sh`.
- Veto or swap: anything in `BACKLOG.md` (queue and proposed) can replace one of these.
- Release steps: merge this branch via PR on the Friday, then tag `v2026.11.06` and create the GitHub release from `RELEASE_NOTES.md`.
