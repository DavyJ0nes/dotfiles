---
name: zk-note
description: Summarize part of the current Claude Code conversation and save it as a markdown note in the user's zk notebook. Use when the user asks to "save to notes", "add to zk", "make a note", "capture this", or similar. Args may scope what to capture (e.g. "the discussion about gum table").
---

# zk-note

Capture a focused summary of the current conversation as a zk note.

## Steps

1. **Decide what to capture.**
   - If args were provided, scope the summary to that topic.
   - Otherwise, summarize the most recent meaningful exchange (problem → resolution).
   - When in doubt, ask the user one clarifying question before writing.

2. **Draft a title.** Short, descriptive, sentence case, no surrounding quotes. Aim for something searchable — e.g. "Fix zsh parse error from done alias", not "How to fix that bug".

3. **Pick 2–5 tags.** Kebab-case. Reuse existing tags where possible (run `zk tag list --format '{{name}}'` to see what's already in the notebook). **Always include `claude`** as one of the tags so these notes are easy to filter later.

4. **Write the body.** Clear markdown — bullet points or short prose. Capture *what was learned or decided*, drop transcript filler. Do NOT include a top-level heading (the template adds one). End the body with a Source line and the inline tags:

   ```
   ---
   Source: Claude Code session — <YYYY-MM-DD> in `<cwd>`

   #claude #tag-one #tag-two
   ```

   Get the cwd with `pwd` and the date with `date +%Y-%m-%d`.

5. **Create the note** via `zk new`, piping the body on stdin:

   ```bash
   path=$(zk new --title "TITLE_HERE" --print-path <<'BODY'
   BODY_CONTENT_HERE

   ---
   Source: Claude Code session — 2026-05-07 in `/some/cwd`

   #claude #tag-one #tag-two
   BODY
   )
   ```

6. **Backfill frontmatter tags.** The default template hard-codes `tags: []`. Replace it with the chosen tags (always including `claude`):

   ```bash
   sed -i '' 's/^tags: \[\]$/tags: [claude, tag-one, tag-two]/' "$path"
   ```

7. **Report the path** so the user can open it (e.g. `nvim "$path"` or `zk edit "$path"`).

## Notes

- The notebook dir is set in `~/.config/zk/config.toml`; do not pass `--notebook-dir`.
- Leave the template's `## Links` section untouched — that's for the user to fill in later.
- Do not invent context. If a section of the conversation is unclear, ask before summarizing it.
- Keep the note self-contained: a future reader should understand it without seeing the original chat.
