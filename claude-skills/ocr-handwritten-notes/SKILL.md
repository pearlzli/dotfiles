---
name: ocr-handwritten-notes
description: Convert a handwritten Notability PDF (synced from iPad into ~/Drive/_notability) into a Markdown file of seminar or reading notes. Use when the user asks to convert, transcribe, or turn a handwritten note PDF into Markdown.
argument-hint: "[date and/or title of the note, e.g. 2026-10-01 Felipe Barbieri]"
---

# Convert handwritten notes to Markdown

The user's handwritten notes sync from Notability on their iPad into `~/Drive/_notability` (mostly under `Research/`, e.g. `Research/Seminars/`). That directory is a temporary inbox: after conversion the user copies the Markdown into Zotero and deletes the files themselves. Don't flag files that have disappeared since an earlier conversion, and don't delete or move anything.

## 1. Find the PDF

Notability names files `YYYY-MM-DD — Title.pdf` with an em dash. The user often types a plain hyphen or `--` instead, so match on the date and title rather than the exact dash, e.g. `find ~/Drive/_notability -name "2026-10-01*Barbieri*.pdf"`. If several files match, or none do, ask.

## 2. Read every page

Get the page count with `pdfinfo`, then Read the PDF with a `pages` range covering all of it (at most 20 pages per Read call). Work from the page images. Any extracted text layer is unreliable OCR with words run together, so use it only as a hint.

Bullets often continue across a page break. Join the continuation to its bullet instead of starting a new one.

## 3. Write the Markdown

Save it next to the PDF with the same name, but with `--` in place of the en/em dash: `2026-10-01 -- Felipe Barbieri.md`.

Structure:

- First line: `# ` followed by the PDF's name without the extension, keeping its original dash (e.g. `# 2026-10-01 — Felipe Barbieri`).
- **Underlined speaker name** (a talk in a multi-talk conference or workshop): a `## Speaker Name` heading. Include a suffix if one is written, e.g. `## Jens Ludwig keynote`.
- **Non-underlined "Name discussion" line** (a discussant): plain paragraph text, not a heading, followed by its bullets. Keep it even if no bullets follow.
- **Single-talk notes** with no speaker headings: just the `#` title, then the bullets.
- Each handwritten bullet is one `- ` list item on a single line. Never hard-wrap.

Transcribe faithfully:

- Keep the user's wording, abbreviations (nbhds, w/, gov'ts, coef), and question marks, including inline `(?)`.
- Keep tags like `[Me]` (the user's own question) and `[Someone]` exactly as written.
- Light cleanup only: capitalize the first word of each bullet, write `vs.` with a period, use en dashes in ranges (`5–25%`, `1945–1968`), and use a real minus sign for negative numbers (`−0.9%`).
- Write math and arrows as plain Unicode, not LaTeX: → ⇒ ↑ ↓ ⊥ × ≥ ≤ Ω. A question mark written above an arrow becomes `→?`. An indicator function becomes `1(...)`.
- Don't add, summarize, or reorganize content.

## 4. Report back

Give the path of the new file and briefly describe its structure. List any words or numbers you weren't sure of, with your best guess and the section each is in. If everything was legible, say so.
