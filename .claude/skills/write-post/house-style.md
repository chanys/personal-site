---
name: house-style
description: Voice rules for Yee Seng Chan's Quarto blog. Loaded by the write-post skill. Plain, declarative, hype-free technical prose with a low vocabulary ceiling and no compressed clauses.
---

# House style

This file holds the **voice**. The structure and Quarto mechanics live in `SKILL.md`.

## The register: plain and declarative

Prefer plain, declarative sentences. Say the thing, then move on.

Do NOT use the antithesis / parallel device in **body** prose:

- No assert-negate-restate ("X didn't win; Y did"). State it once, plainly.
- No hard "not X, but Y". State Y positively; a light trailing "not X" appositive is the most you keep.
- No two-beat parallel/antithesis pairs ("A does X. B does Y."). Write them flat and keep both facts, e.g. "Logs record what happened; traces show why."
- No reframe announcements: "Here's the thesis:", "The better framing is...", "The phrase to remember:". Delete the announcement and state the point.

Keep the antithesis device ONLY in **titles and section headings**, which is its one home.
In a closing or other high-impact line, a minimal "rather than" is allowed; do not force it.

Leave these alone (they are not the device):

- Staccato negative lists and triads: "No rollouts. No value network. No reward model."
- Functional recaps that enumerate 3+ distinct components.

## Density is the main failure mode

Concision and density are different things. A sentence carrying three ideas with the connective words stripped out is dense, not tight, and it is the most common problem in a first draft.

- **One idea per sentence.** If a sentence has a colon, a comma splice, and a subordinate clause, it is three sentences.
- **Keep the connective words.** "Then", "so", "because", "which means". These are what make prose readable; removing them does not make it sharper.
- **Unpack, do not compress.** Plain prose needs more words than compressed prose. A longer draft that reads at speed beats a shorter one the reader has to decode.

Examples of the failure, from real drafts:

> A server exposing four tools over a CSV of Massachusetts town data: median home price, school rating, crime rate, distance to Boston. Two hosts against it. The first is driven by `argv`, with no model involved.

Four fragments, no verbs doing work. Rewrite as full sentences, one thing each.

> For one local Python function that I own, a direct import is simpler. In-process dispatch is a dict lookup, and MCP adds a subprocess, a session, and an async boundary to reach it.

Two dense sentences. Split them and name what a dict lookup means.

## No coreference across a gap

If the referent is more than a sentence away, name it again. The reader should never have to hold something in memory to parse the next sentence.

Failures to watch for:

- **Vague back-reference.** "The same two structures", "this is the client from the three roles above", "that description".
- **Unnamed nouns.** "The SDK" (which SDK?), "the protocol" (which protocol?), "the provider" (name it, or give an example: "the model provider (OpenAI, Anthropic)").
- **First-person in figures.** A diagram has no surrounding sentence to establish who "my" is. Label figure elements neutrally: "Tool owner's function", "Host's copy of it".

## Vocabulary ceiling

Technical terms of art are fine. Elevated register is not. If a plainer word exists, use it.

Banned in body prose: bespoke, load-bearing, orchestration, volumetric, splat, taxonomy, conceptual, by construction, entirety, paradigm, leverage, robust, delve, foster, utilize.

Rewrites that worked:

| Instead of | Write |
| --- | --- |
| bespoke integrations | one-off integrations |
| the load-bearing part | the part doing the work |
| owns the orchestration | owns the loop that ties them together |
| structural rather than volumetric | about structure, not about how much code you write |
| the arguments splat onto | the arguments are passed to |
| for the same conceptual operation | for what is really the same operation |
| discovery is not the entirety of MCP | MCP does more than discovery |

## Patterns to cut

- **Colon reveals.** A noun phrase, a colon, then a dramatic lowercase clause. Use colons for lists, labels, and quotes.
- **Faux-insight setups.** "What most people get wrong", "the part everyone misses", "this is the part most people skip". Cut the setup and let the claim stand.
- **Importance puffery.** "Marks a pivotal moment", "plays a vital role", "underscores its significance". State the fact.
- **Superficial `-ing` clauses.** "...highlighting the team's commitment", "...reflecting a broader shift". These pretend to explain. Say what actually follows.
- **Weasel attribution.** "Experts agree", "studies show", "many argue". Name the source or cut the claim.
- **Self-qualifying filler.** "That is a narrow claim, and worth keeping narrow." Either make the claim precise or do not announce that you are being precise.
- **Fake-profound kickers.** Delete the final "deep" line. End on the clearest concrete sentence already in the draft.
- **Summary-recap endings.** The reader was just there.

## Always

- No em dashes. Use a plain dash, a comma, or restructure.
- No hype or clickbait. "Boring" is a virtue.
- No hedging filler. Quantify instead.
- No throat-clearing transitions.
- Preserve technical content. Flatten how prose reads, never what it claims.

## Code in articles

- **One whole program beats three fragments.** Splitting a coherent piece of code into snippets loses how the parts connect. If the reader needs to see `SERVERS`, the connection loop, and the call, put them in one block.
- **Run every example.** Printed output in the article is real output from a real run. Never invent a result.
- **Comment inside the code, not around it.** A paragraph explaining a line of plumbing is worse than a trailing comment on that line. `# bookkeeping: closes every connection on the way out` beats three sentences.
- **Name the same thing the same way.** If the before-code calls it `DISPATCH`, the after-code calls it `dispatch`, not `routes`. Different names for one idea read as two ideas.
- **Use reserved example domains.** `api.example.com`, not a real endpoint a reader might try.
- **Gloss unfamiliar library names before the block.** One bullet each, one sentence each. Three is the ceiling; past that, the code is doing too much.

## Figures

- **Two per article is usually the limit.** More than that and they compete with each other and with the prose.
- **Captions stand alone.** Long and information-dense. A reader who only looks at figures should get the argument from the captions.
- **Prose and caption must not restate each other.** If the caption covers the failure modes, the prose stops before them.
- **Every figure needs `fig-alt`.** Mirror the SVG's `<desc>` element.
- **Colour encodes meaning, not sequence.** Pick one colour for "broken or hand-maintained" and one for "correct or owned elsewhere". Do not cycle through a palette.
- **Do not diagram something the article is arguing past.** If a paragraph exists to dismiss a familiar diagram, drawing it gives it weight the argument does not want.
- **Repetition should be visible inside the boxes.** If the point is that entries multiply, show two entries, not one box labelled "entries".

## Voice self-check (run on any draft)

Scan for and fix:

- Any sentence carrying three or more ideas. Split it.
- Any referent more than a sentence from its noun. Name it again.
- The banned devices above appearing in body prose (antithesis, two-beat pairs, reframe announcements).
- Words from the vocabulary ceiling list.
- Em dashes.
- Hype words, importance puffery, throat-clearing transitions.
- A new term used without a bold-term-plus-gloss introduction.
- A figure missing `fig-alt`, or a heading that labels instead of claiming.
- Prose that restates a figure caption.
- Code output that was not actually run.
- Any invented metric, citation, or biographical fact (replace with `▸ EDIT ME`).
- A closing that names sections the article no longer contains.