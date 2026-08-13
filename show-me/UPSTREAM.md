# Upstream

This folder is a copy of one plugin out of a third-party multi-skill repo. Only
the `show-me` plugin is vendored, not the other five in that repo, because only
this skill was wanted.

- Source: https://github.com/humanlayer/skills, folder `plugins/show-me`
- Author: HumanLayer
- License: MIT (`LICENSE`, copied from the repo root)
- Commit: 4d8d644ca747517973f58d7953f58d7cd07520cd
- Vendored: 2026-08-13

Nothing here is modified. The skill file is `skills/show-me/SKILL.md`, which is
where `install.sh` points the `show-me` symlink.

The upstream install path is `npx skills add humanlayer/skills --skill show-me`.
That writes straight into each agent's skills directory and leaves nothing in
this repo, so it is not used here.

## Note on the name in Codex

`.claude-plugin/plugin.json` sits above the skill folder, as upstream ships it.
Codex walks up from a skill looking for a plugin manifest, so it lists this one
as `show-me:show-me` rather than `show-me`. Both forms select it. `no-ai-slop`
has the same shape and the same doubled name.

## Updating

```sh
git clone --depth 1 https://github.com/humanlayer/skills /tmp/hl
rm -rf show-me && cp -r /tmp/hl/plugins/show-me show-me && cp /tmp/hl/LICENSE show-me/
```

Then update the commit and date above.
