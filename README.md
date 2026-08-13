# skills

Personal Claude Code skills. One folder per skill at the repo root.

## Skills

Written here:

- `bro` : restate the last message in plain human language, no jargon.
- `interview` : question the user with AskUserQuestion to pin down intent and
  fill the gaps before any work starts.
- `first-principles` : strip a problem to physical, mathematical and
  raw-material truths, compute the theoretical floor, and rebuild from there.

`bro` and `interview` are user-invoked only (`disable-model-invocation: true`),
so they run when you type `/bro` or `/interview`, never on the model's own
initiative. `first-principles` carries its own activation triggers, so it fires
on design, cost, and optimization questions by itself. Add
`disable-model-invocation: true` to its frontmatter to make it slash-only too.

Vendored from other people, MIT, copied whole with the upstream commit recorded
in each folder's `UPSTREAM.md`:

- `human-review` : open an HTML file, Markdown file, or localhost page in the
  browser, edit it directly, leave comments, and send the whole batch back to
  the agent. From https://github.com/petergyang/human-review by Peter Yang.
- `no-ai-slop` : edit a draft into sharper, more human writing, or report which
  AI-slop patterns it hits. From https://github.com/petergyang/no-ai-slop by
  Peter Yang.
- `show-me` : answer visually instead of in walls of prose, with pseudocode,
  call trees, file trees, Mermaid diagrams, diffs, or one focused HTML page.
  From https://github.com/humanlayer/skills by HumanLayer, which holds five
  more skills that are not vendored here.

## Install

```sh
./install.sh
```

It symlinks each skill into every agent home on the machine, so an edit in this
repo takes effect at once, everywhere:

- `~/.claude/skills/` for Claude Code.
- `~/.codex/skills/` and `~/.codex-tatul/skills/` for Codex, one per account.
  A home that does not exist is skipped, never created.
- opencode needs nothing. It auto-loads `~/.claude/skills/` itself, so linking
  it again would only list every skill twice.

All three follow the symlinks, which was checked rather than assumed: Codex
lists all five in `codex debug prompt-input`, and opencode lists them on the
`/skill` endpoint of `opencode serve`.

`install.sh` refuses to overwrite a real directory already sitting in a target,
unless you pass `--force`. Set `CLAUDE_SKILLS_DIR` to link into one directory
only, and put project-only skills in `<repo>/.claude/skills/` instead.

A vendored folder keeps its upstream layout, so its `SKILL.md` is not at the
folder root. `install.sh` holds the inner path for each one.

`human-review` ships real code, so it needs one more step:

```sh
cd human-review && npm install && npm link
```

That puts a `human-review` binary on PATH that points back into this repo. `npx`
checks PATH before the npm registry, so the skill then runs this copy instead of
downloading the published package. Node 20 or newer.

Restart Claude Code after adding a skill. It reads the directory at startup.
