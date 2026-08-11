# Upstream

This folder is a full copy of a third-party project, kept whole rather than
reduced to its `SKILL.md`, so this repo carries the code that actually runs.

- Source: https://github.com/petergyang/human-review
- Author: Peter Yang
- License: MIT (see `LICENSE`, kept as shipped)
- Version: v0.6.0
- Commit: 64deff14506cfc18d542d28fb7b7e0ac98c0c459
- Vendored: 2026-08-11

Nothing here is modified. The skill file is `src/SKILL.md`, which is where
`install.sh` points the `~/.claude/skills/human-review` symlink.

## Running the vendored code, not the published package

`src/SKILL.md` tells the agent to run `npx -y human-review`. `npx` looks on PATH
before it reaches the npm registry, so a global link to this folder makes that
command run this copy:

```sh
cd human-review
npm install
npm link
```

Check it with `which human-review`. The path must point back into this repo. If
you skip the link, the command downloads version 0.6.0 from npm instead, and
this folder is only an archive.

## Updating

```sh
git clone --depth 1 https://github.com/petergyang/human-review /tmp/hr
rm -rf human-review && cp -r /tmp/hr human-review && rm -rf human-review/.git
```

Then update the version, commit, and date above, and re-run `npm install`.
