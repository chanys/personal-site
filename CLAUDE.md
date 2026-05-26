# CLAUDE.md

Guidance for Claude Code working in this repo. Read this before editing.

## What this is

Personal site + blog for Yee Seng Chan, built with **Quarto** (static site),
deployed to **yeesengchan.com**. Content is `.qmd`; design is SCSS. No JS build,
no framework. Aesthetic is deliberate — see *Design system* before restyling.

## Commands

```bash
quarto preview              # dev server, live reload — use to verify changes
quarto render               # full build into _site/
quarto publish gh-pages     # deploy (CNAME is kept as a project resource)
```

Always `quarto preview` (or `render`) after edits and read the console:
Quarto warnings are signal, not noise. Do not hand-edit `_site/` or `.quarto/`
(generated; git-ignored).

## Two hard rules (these already broke the build once)

1. **No `url(...)` in any CSS Quarto scans.** Quarto's dependency copier reads
   `url(...)` as a file path. URL-encoded SVG data URIs contain `url(%23id)`
   for filter refs and will crash the build (`lstat '%23id'`). **Always
   base64-encode SVG data URIs** (`url("data:image/svg+xml;base64,…")`) — a
   base64 blob can't contain the substring `url(`. Same applies to background
   images, masks, filters.

2. **Never reference a custom Sass `$variable` inside `/*-- scss:defaults --*/`.**
   Quarto relocates known Bootstrap variable assignments above custom ones →
   "variable used before declaration". The architecture that avoids this:
   - `scss:defaults` → Bootstrap/Quarto vars only, **literal values** (no `$x`).
   - `scss:rules` → defines the palette as `--fn-*` **CSS custom properties**.
   - `fieldnotes-rules.scss` → all component styling, **theme-neutral**, reads
     `var(--fn-*)` only. It must contain **zero Sass `$` variables**.

   To change a colour: edit the `--fn-*` token in `theme.scss` (light) and
   `theme-dark.scss` (dark). To change a component's look: edit
   `fieldnotes-rules.scss` once (applies to both themes).

## File map

```
_quarto.yml            nav, theme array, fonts (Google Fonts via header), footer
theme.scss             light: Bootstrap literals + --fn-* light tokens
theme-dark.scss        dark:  Bootstrap literals + --fn-* dark tokens
fieldnotes-rules.scss  shared component rules (loaded after both themes)
styles.css             tiny additive-only extras (focus ring, print)
index.qmd              home (trestles "about" landing)
writing.qmd            blog index (lists standalone posts + series landings)
series.qmd             lists series only
projects.qmd  about.qmd
posts/
  _metadata.yml                      shared front-matter for ALL posts
  <slug>/index.qmd                   standalone post
  series/<series-slug>/
    _metadata.yml                    series category (applies to all parts)
    _series.qmd                      "Part of a series" box (shared, included)
    index.qmd                        series landing (auto-lists parts)
    NN-<slug>/index.qmd              a part
```

Theme files are listed as arrays in `_quarto.yml`
(`[theme.scss, fieldnotes-rules.scss]`); order matters — shared rules load last.

## Content conventions

- **Standalone post:** `posts/<slug>/index.qmd`, front-matter `title`,
  `description` (one sentence, shows on index + feed), `date`, `categories`.
- **Series:** a folder under `posts/series/`. Listing globs depend on this
  exact depth — do not flatten:
  - `posts/*/index.qmd` → standalone posts + series landings (on Writing index)
  - `posts/series/*/index.qmd` → series landings (on Series page)
  - parts are `posts/series/<s>/NN-<p>/index.qmd` — **never** on the main
    index by design; only on their series landing + that series' feed.
- **A series shows as ONE entry** on Writing. Don't "fix" this by adding parts
  to `writing.qmd` unless explicitly asked (the one-line opt-in is commented
  in that file).
- `order:` (int) sets a part's position in the series; `date:` only sets where
  the series *landing* sorts on the Writing index. They are independent.
- The series landing's parts list is **generated** (`sort: "order"`). Never
  hand-maintain it. The only hand-maintained list is `_series.qmd` (one link
  line per part; links are sibling-relative `../NN-slug/`).
- Files/dirs starting with `_` are never rendered as pages. `_series.qmd` is
  included into parts via `{{< include ../_series.qmd >}}` (path is relative
  to the including part).
- New series → also add a category in that series' `_metadata.yml`. Document
  front-matter overrides `_metadata.yml` (no merge), so if a part needs extra
  categories it must repeat the series one.

## Design system (don't drift)

Direction: **"Field Notes"** — editorial-technical, warm paper/ink, a single
signal-vermilion accent used sparingly, serif system for long-form reading.
The opposite of generic AI-template styling. Preserve this character; avoid
adding gradients, drop shadows, rounded "card" UI, or extra accent colours.

- **Type:** Fraunces (display/headings/nameplate), Newsreader (body),
  IBM Plex Mono (dates, code, metadata, nav). Loaded via Google Fonts in
  `_quarto.yml` `include-in-header`. Don't swap fonts without reason.
- **Tokens** (`--fn-*`): `paper`, `paper-sink`, `card`, `ink`, `ink-soft`,
  `hairline`, `accent`, `accent-deep`, `grain-opacity`, `navbar-bg`.
- Both light and dark must stay tuned. If you touch one, check the other in
  `quarto preview` (theme toggle, top-right).
- Motion: one quiet staggered page-load reveal, gated on
  `prefers-reduced-motion`. Keep it restrained.

## Editing guardrails

- **Do not invent biographical facts** about the owner (degrees, employers,
  history). Real specifics are intentionally left as `▸ EDIT ME` markers —
  grep for them; leave them as placeholders unless given the real content.
- Prose: tighten, don't pad. Restrained formatting; the body is for reading.
- Keep `styles.css` minimal and additive — colour/layout belongs in SCSS so it
  tracks the theme tokens.
- After any change: `quarto preview`, confirm no console warnings, check both
  themes and a post, a series landing, and a part.
