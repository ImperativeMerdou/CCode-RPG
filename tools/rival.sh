#!/usr/bin/env bash
# rival.sh — the ladder climbs itself. Roll once per session for the most active rival.
#   ./rival.sh
# Write the move to state/rivals.md. Rivals never idle.
set -euo pipefail

moves=(
  "TRAINED: they got measurably better; note where (their next scene shows it)"
  "RECRUITED: a new name swears to them; their crew grows by a face worth writing"
  "EARNED: a job landed; they're flush; money moves ahead of them now"
  "BLED: they lost something (a fight, a member, a stash); they are meaner for it"
  "WATCHED: they learned something true about Merdou; write WHAT into threads"
  "CLIMBED: they took a visible step up the ladder; the street repriced them"
  "OVERREACHED: they made an enemy above their weight; a clock starts for them"
  "CROSSED: their path touched Merdou's world (his people, his turf, his job board); contact next session"
)

d=$(( (RANDOM % 8) + 1 ))
echo "d8=$d: ${moves[$((d-1))]}"
