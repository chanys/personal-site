# House style (customize this)

This file holds the **voice** the `write-post` skill enforces.
It ships one author's register: plain, declarative, hype-free technical prose.
The structure and Quarto mechanics in `SKILL.md` are portable; **this file is where you encode your own voice**, so replace these rules freely with your own.

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

Always:
- No em dashes. Use a plain dash, or restructure the sentence.
- No hype or clickbait. "Boring" is a virtue.
- No hedging filler. Quantify instead.
- No throat-clearing transitions.
- Preserve technical content. Flatten how prose reads, never what it claims.

## Voice self-check (run on any draft)

Scan for and fix:
- The banned devices above appearing in body prose (antithesis, two-beat pairs, reframe announcements).
- Em dashes.
- Hype words, importance puffery, or throat-clearing transitions.
- A new term used without a bold-term-plus-gloss introduction.
- A figure missing `fig-alt`, or a heading that labels instead of claiming.
- Any invented metric, citation, or biographical fact (replace with `▸ EDIT ME`).
