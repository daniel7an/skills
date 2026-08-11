# Upstream

This folder is a full copy of a third-party project, kept whole rather than
reduced to its `SKILL.md`.

- Source: https://github.com/petergyang/no-ai-slop
- Author: Peter Yang
- License: MIT (see `LICENSE`, kept as shipped)
- Commit: d30eddb9e04562234f2070b5ee63ca4649d9a05e
- Vendored: 2026-08-11

Nothing here is modified. The skill file is `skills/no-ai-slop/SKILL.md`, which
is where `install.sh` points the `~/.claude/skills/no-ai-slop` symlink. The
symlink targets that inner folder, not the repo folder, because `SKILL.md` reads
`eval.md` from beside itself.

The skill is prompt only. It needs no install step and no dependencies.

## Updating

```sh
git clone --depth 1 https://github.com/petergyang/no-ai-slop /tmp/nas
rm -rf no-ai-slop && cp -r /tmp/nas no-ai-slop && rm -rf no-ai-slop/.git
```

Then update the commit and date above.
