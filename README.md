# yeesengchan.com

Personal site + blog, built with [Quarto](https://quarto.org).

## Run locally

```bash
quarto preview        # live-reloading dev server
quarto render         # build static site into _site/
```

## Structure

```
_quarto.yml            site config: nav, theme array, fonts, footer
theme.scss             light: Bootstrap vars + --fn-* light tokens
theme-dark.scss        dark:  Bootstrap vars + --fn-* dark tokens
fieldnotes-rules.scss  shared component rules (theme-neutral, var(--fn-*))
styles.css             tiny additive extras (focus ring, print)
favicon.svg            mark
index.qmd  writing.qmd  series.qmd  projects.qmd  about.qmd
posts/
  _metadata.yml                       shared front-matter for ALL posts
  <slug>/index.qmd                    a standalone post
  series/<series-slug>/
    _metadata.yml                     series category, applied to every part
    _series.qmd                       the "Part of a series" box (shared)
    index.qmd                         series landing (auto-lists parts)
    01-<slug>/index.qmd               part 1
    02-<slug>/index.qmd               part 2  ...
```

The theme is split so the colour system lives in one place: each theme file
only defines Bootstrap variables (literal values) plus a block of `--fn-*`
CSS custom properties; `fieldnotes-rules.scss` is loaded after both and styles
everything by reading those tokens. Edit a colour once, both modes update.

## Add a standalone post

Create `posts/my-slug/index.qmd`:

```yaml
---
title: "Title"
description: "One sentence — shows on the Writing index."
date: 2026-03-01
categories: [agents, evaluation]
---
```

It appears on `/writing` and in the site feed automatically.

## Add a series

A series is a folder under `posts/series/`. The Writing index shows the
series as **one entry** (its landing page); the individual parts are listed
only on the series' own page and in that series' feed.

1. Make the folder: `posts/series/my-series/`
2. `posts/series/my-series/_metadata.yml`

   ```yaml
   categories: ["My Series Name"]
   series: "My Series Name"
   ```

3. `posts/series/my-series/index.qmd` — the landing. Copy the example's
   front-matter; the parts list under it is generated automatically (sorted
   by each part's `order:`), so you never hand-maintain it.
4. One folder per part: `posts/series/my-series/01-first/index.qmd`, with:

   ```yaml
   ---
   title: "Part title"
   description: "One sentence."
   date: 2026-03-01
   order: 1            # position in the series (independent of date)
   ---

   {{< include ../_series.qmd >}}
   ```

5. `posts/series/my-series/_series.qmd` — the shared "Part of a series" box.
   Add one line per part; links are sibling-relative (`../NN-slug/`).

`order:` controls series sequence; `date:` controls where the landing sits on
the Writing index. Files starting with `_` are never rendered as pages.

Want every part in the **main** index/feed too? Add one line to the
`contents:` list in `writing.qmd` (it's noted in the comment there).

## Deploy

The `CNAME` (`yeesengchan.com`) is preserved as a project resource. Publish
with `quarto publish gh-pages`, or render and serve `_site/`.

## Editing notes

Search the source for `▸ EDIT ME` — those mark placeholder copy (your bio,
project specifics) I deliberately did not invent. The example posts and the
example series under `posts/` are replaceable templates.
