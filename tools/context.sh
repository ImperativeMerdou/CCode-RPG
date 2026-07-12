#!/usr/bin/env bash
# context.sh — session boot in one command. Runs the ritual's dice and prints
# the world's pulse. The GM still reads the files; this is the drumroll.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

echo "=== NOW ==="
sed -n '/## Now/,/^$/p' state/world.md | tail -n +2

echo "=== WEATHER (Flamerule d6) ==="
./tools/roll.sh 1d6 --label "weather"

echo "=== WORLD BEATS ==="
./tools/event.sh 2

echo "=== RIVAL MOVE ==="
./tools/rival.sh

echo "=== CLOCKS (visible) ==="
grep '^|' state/clocks.md | tail -n +3

echo "=== CONSEQUENCES DUE ==="
grep '^|' state/consequences.md | tail -n +3

echo "=== OPEN THREADS ==="
grep -c '^|' state/threads.md | awk '{print $1-2" threads open (read state/threads.md)"}'

echo "=== JOBS LIVE ==="
grep -c '^|' state/jobs.md | awk '{print $1-2" rows on the board (read state/jobs.md)"}'

echo "=== VITALS ==="
./tools/statusline.sh
