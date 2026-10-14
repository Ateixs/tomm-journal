# CRYSTAL — ACM TOMM manuscript

Upload this zip to Overleaf (New Project → Upload Project). The `acmart`
class is preinstalled on Overleaf; no class files are bundled.
Compiler: pdfLaTeX. Main document: `main.tex`.

## Layout
- `main.tex` — preamble, ACM metadata, macros, `\input` of sections
- `sections/` — one file per section; write here
- `references.bib` — BibTeX, `ACM-Reference-Format` style
- `acronyms.tex` — glossaries entries; `\gls{key}` expands on first use, `\glspl{}` plural, `\glsentryshort{}` in tables/titles. Terminology macros (`\vpcc`, `\qoe`, `\mos`, `\hmd`, `\gof`, `\fiveg`…) route through `\gls`; `\quic` is literal (RFC 9000: a name, not an acronym). `\glsresetall` after `\maketitle` so the Introduction re-expands after the abstract.
- `figures/` — PDFs/PNGs (resolved via `\graphicspath`)

## Modes
`main.tex` line 12: `[acmsmall,review,anonymous,screen]` for submission
(double-anonymous, line numbers). Swap for `[acmsmall,screen]` for the
camera-ready/preprint. `\anon[review text]{final text}` (built into acmart) switches content.

## Model (current, Oct 2026)
Two-layer: Layer 1 derives the temporal loss fraction ψ from transport
quantities; Layer 2 is MOS = 1 + 4·Q̃_c·e^(−αψ). V-PCC only; GoF size is
the structural variable; Udora et al. is the external baseline. Macros:
`\crystalmodel`, `\crystallayerone`, `\tlf`, `\qc`.

## Before submission
- Resolve every `\todo{}` / `\note{}`, then delete the macro definitions
- Generate CCS concepts at https://dl.acm.org/ccs and paste the XML block
- Refer to MOSAIC/VQUEST in the third person while `anonymous` is on
- Fill ORCIDs and check `\shortauthors` / short title for running heads
