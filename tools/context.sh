#!/usr/bin/env bash
# context.sh — session boot in one command. Runs the ritual's dice and prints
# the world's pulse. The GM still reads the files; this is the drumroll.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

echo "=== NOW ==="
sed -n '/## Now/,/^$/p' state/world.md | tail -n +2

echo "=== WEATHER (Flamerule d6) ==="
W="$(./tools/roll.sh 1d6 --hidden)"
case "$W" in
  1) echo "d6=1: forge heat, no wind; tempers fray by noon" ;;
  2) echo "d6=2: hot and still; flies on everything; the harbor stinks" ;;
  3) echo "d6=3: sea wind; a fair day by Gate standards" ;;
  4) echo "d6=4: overcast, muggy; rain hangs over the harbor and waits" ;;
  5) echo "d6=5: rain in earnest; torches drown, footsteps too" ;;
  6) echo "d6=6: storm off the sea; shutters banging, streets emptied" ;;
esac

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
