#!/usr/bin/env bash
# Symlink every skill in this repo into ~/.claude/skills, so an edit here is live at once.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
force=0
[ "${1:-}" = "--force" ] && force=1

# A vendored project keeps its upstream layout, so its SKILL.md is not at the
# folder root. The second field is the folder that holds SKILL.md.
skills=(
  "bro:bro"
  "first-principles:first-principles"
  "interview:interview"
  "human-review:human-review/src"
  "no-ai-slop:no-ai-slop/skills/no-ai-slop"
)

mkdir -p "$dest"
for entry in "${skills[@]}"; do
  name="${entry%%:*}"
  src="$repo/${entry#*:}"
  link="$dest/$name"
  if [ ! -f "$src/SKILL.md" ]; then
    echo "skip $name: no SKILL.md in $src"
    continue
  fi
  if [ -L "$link" ]; then
    rm "$link"
  elif [ -e "$link" ]; then
    if [ "$force" = 1 ]; then
      rm -rf "$link"
    else
      echo "skip $name: $link is a real directory, pass --force to replace it"
      continue
    fi
  fi
  ln -s "$src" "$link"
  echo "linked $name -> $src"
done

if [ ! -d "$repo/human-review/node_modules" ]; then
  echo
  echo "human-review still needs its dependencies and a global bin, or it runs"
  echo "the published npm package instead of this copy:"
  echo "  (cd $repo/human-review && npm install && npm link)"
fi

echo
echo "Restart Claude Code to pick up any new skill."
