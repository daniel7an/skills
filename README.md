# skills

Personal Claude Code skills. One folder per skill at the repo root.

## Skills

Written here:

- `bro` : restate the last message in plain human language, no jargon.
- `interview` : question the user with AskUserQuestion to pin down intent and
  fill the gaps before any work starts.

Both are user-invoked only (`disable-model-invocation: true`), so they run when
you type `/bro` or `/interview`, never on the model's own initiative.

Vendored from other people, MIT, copied whole with the upstream commit recorded
in each folder's `UPSTREAM.md`:

- `human-review` : open an HTML file, Markdown file, or localhost page in the
  browser, edit it directly, leave comments, and send the whole batch back to
  the agent. From https://github.com/petergyang/human-review by Peter Yang.
- `no-ai-slop` : edit a draft into sharper, more human writing, or report which
  AI-slop patterns it hits. From https://github.com/petergyang/no-ai-slop by
  Peter Yang.

## Install

```sh
./install.sh
```

It symlinks each skill into `~/.claude/skills/`, so an edit in this repo takes
effect at once. It refuses to overwrite a real directory already sitting there,
unless you pass `--force`. Set `CLAUDE_SKILLS_DIR` to link somewhere else, and
put project-only skills in `<repo>/.claude/skills/` instead.

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
