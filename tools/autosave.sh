#!/usr/bin/env bash
# autosave.sh — the crash net under the GM's manual commits.
# Runs on the Stop hook: if the session left game state uncommitted, the
# Chronicler saves it. Never blocks, never fails loudly.
REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO" || exit 0
if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
  git add -A >/dev/null 2>&1
  git commit -m "The Chronicler saved what the session left open" \
    -m "Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>" >/dev/null 2>&1
  git push --quiet >/dev/null 2>&1
fi
exit 0
