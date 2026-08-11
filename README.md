# skills

Personal Claude Code skills. One folder per skill, each holding a `SKILL.md`,
so the layout mirrors `~/.claude/skills/` one to one.

## Skills

- `bro` : restate the last message in plain human language, no jargon.
- `interview` : question the user with AskUserQuestion to pin down intent and
  fill the gaps before any work starts.

Both are user-invoked only (`disable-model-invocation: true`), so they run when
you type `/bro` or `/interview`, never on the model's own initiative.

## Install

Symlink a skill into the user-level skills directory, so edits here take effect
at once:

```sh
ln -s "$PWD/bro" ~/.claude/skills/bro
```

Or copy it, if you would rather pin a version:

```sh
cp -r bro ~/.claude/skills/bro
```

Project-level skills go in `<repo>/.claude/skills/` instead.
