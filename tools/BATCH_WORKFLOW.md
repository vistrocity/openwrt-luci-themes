# Weekly batch workflow

Four new themes every Friday. Automation: a Thursday-evening task builds the next four themes from `BACKLOG.md` and opens a PR;
a Friday-morning task merges it unless the owner has commented to stop it. Tags and GitHub Releases are created by hand by the owner.

## Steps (build)

1. `git fetch origin && git worktree add /tmp/wt-batch -b release/batch-N-YYYY-MM-DD origin/main`
2. Take the first four rows under "Proposed" in `BACKLOG.md`.
3. For each, write a small Python script that calls `tools/lib/build_theme.py` (`make(slug, name, tag, title, light, color, p, extra, btn, svg, batch)`).
   - `p` is the palette dict (see `scaffold.LIGHT` / `scaffold.DARK` for keys), `extra` is the redesign CSS, `btn` comes from `buttons(...)`, `svg` is a new logo.
   - Real redesign, not a recolour; no third-party brands or characters; `prefers-reduced-motion` respected; usable at phone width.
4. Gotchas learned so far:
   - Base CSS hides `header .brand` at 854px and sets `.pull-right`; use `header a.brand` and `header #indicators { display:none !important }` in your overrides.
   - The QA contrast check reads `background-color` only: give gradients a solid colour fallback (`background: <gradient> #hex`).
   - Inline footer scripts are allowed only if they make no network calls, use no storage, no eval, no external URLs.
5. `tools/check-theme.sh <slugs> --qa`, look at `/tmp/owt-qa/<slug>-*-phone.png`, fix findings.
6. `tools/screenshots.sh <slugs>` and view the desktop JPGs; `tools/test-install.sh <slugs>`.
7. Write `releases/<date>/RELEASE_NOTES.md` (copy the last one), update `BACKLOG.md` (move the four to Built; if fewer than 8 Proposed remain, add 8 more ideas).
8. Commit (never commit Reddit drafts or any outreach text), push, open a PR with previews. `main` is protected: merge via PR only (squash).
