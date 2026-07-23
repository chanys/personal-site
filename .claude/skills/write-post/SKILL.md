---
name: write-post
description: Draft or review an article for a Quarto blog. Enforces a strong argued article structure, correct Quarto front matter / listing / figure conventions, and a customizable house-style voice. Use when creating, drafting, or editing posts under a Quarto site's posts/ directory.
---

# Write-post

Draft or voice-edit an article for a Quarto blog so it has a clear argued structure, correct Quarto mechanics, and a consistent, hype-free voice.

Two modes:
- **Draft** a new post from a topic.
- **Review** an existing draft: flag issues and propose minimal edits.

## How this skill is organized

- **This file** is the portable craft: article structure, Quarto mechanics, and the workflow. It applies to any Quarto blog.
- **`house-style.md`** holds the voice rules. It ships one author's plain, declarative register. This is the part you customize: swap in your own voice and leave the structure below unchanged.
- If the repo has a **`CLAUDE.md`**, read it for the project's file map, theme, and build gotchas, and defer to it on anything project-specific.

## Adopting this skill on your own blog

Change two things, nothing else:
1. Rewrite `house-style.md` to your own voice.
2. Match the paths in "Quarto mechanics" below to your site's listing configuration (the directory layout and globs are conventions, not requirements).

## Before drafting, gather

- The **thesis** in one sentence: what the reader should believe after reading. If the topic is vague, pin it down first.
- **Standalone** post or **series part**? If a part: which series, and its `order:` position.
- **Categories** for the front matter.
- Any **real** metrics, named systems, datasets, and `[@author_year]` citations to ground it.
- Whether it is a **code/research** post (those end with a "Code companion" repo link).

Never fabricate metrics, citations, or facts about a real person (bio, employer, numbers). Where a real specific is needed but unknown, leave a `▸ EDIT ME` marker rather than inventing one.

## Quarto mechanics

Paths below are a common Quarto blog layout; adapt them to your site's listing globs.

- **Standalone post:** `posts/<slug>/index.qmd`.
- **Series:** one folder per series, parts nested one level with an integer `order:` field, and a shared "part of a series" snippet included into each part. (This repo uses `posts/series/<series>/NN-<slug>/index.qmd` with `{{< include ../_series.qmd >}}` as the first body line.)
- **Front matter:** `title`, `description` (one sentence; shows on the index and the feed), `date`, `categories`, `draft: false`.
- **Figures:** a markdown image on its own line renders as a `<figure>`, and `fig-alt` renders as a visible caption. For a chromeless image use raw `<img>` HTML. Always provide `fig-alt`.
- A new sibling directory needs a `quarto preview` **restart**, not just a reload.

## Article structure (the transferable craft)

- **Title** is a compressed thesis or reframe, not a topic label: an identity claim ("PPO is REINFORCE plus five fixes"), a myth-correction ("The encoder didn't die. It became the embedding model"), second-person ("Your RAG score hides the diagnosis"), or an imperative ("Stop vibe-checking your agent"). Avoid listicle numbers and buzzword-colon subtitles.
- **Description** is the thesis compressed to one line, often echoed as the closing line.
- **Open cold**, no throat-clearing. Either name the received belief and puncture it ("The standard story is X. I think that is shallow."), or drop into a concrete scene or verbatim quote.
- **Argument arc:** puncture -> reframe -> enumerate -> one concrete running example -> payoff. Undercut your own overclaim with a carve-out section ("What X still does").
- **Close** on a compressed reframe. Optionally add a short bullet arc linking sibling posts. Ring composition (end near the opening thesis) reads well.
- **Diction:** concrete, named, grounded, hype-free. Cash out every abstraction in a worked number, named system, or case ("To make this concrete, ..."). Introduce a new term as **bold term** plus a one-sentence gloss.
- **Formatting fingerprint:** headings are claims, not labels; `**Term.** explanation` definition bullets; figures carry long, information-dense captions and always a `fig-alt`; code blocks and worked numbers carry the technical weight; code/research posts end with a "Code companion" section linking the repo.

## Voice

Apply the rules in `house-style.md`, and run its self-check on the finished draft.

## Workflow

**Draft mode:** gather the inputs above -> create the file at the correct path -> write the front matter and body following the structure -> run the `house-style.md` self-check -> render.

**Review mode:** scan the draft, and for each issue report the verbatim line, the rule it breaks, and a one-line minimum-effective fix. Preserve titles, section headings, math (`$...$`, `$$...$$`), code, tables, citations, links, and all technical content. Do not blandify prose that carries no problem.

## After writing

Run `quarto render` (or render just the touched series directory) and read the console; Quarto warnings are signal. New files or `_quarto.yml` changes need a preview restart. Do not hand-edit `_site/` or `.quarto/`.
