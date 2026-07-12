#!/usr/bin/env bash
# rumor.sh — what the taverns are saying. GM fills the frame from the state files.
#   ./rumor.sh        one rumor: a frame + a truth grade
#   ./rumor.sh 3      three
# Truth d6: 1-2 TRUE (pull a real line from state/), 3-4 TWISTED (real thing, wrong detail),
# 5-6 FALSE (pure invention; the street dreamed it). Even false rumors move markets and men.
set -euo pipefail
COUNT="${1:-1}"

frames=(
  "a docker swears he saw ___ with his own eyes, third bell, no moon"
  "two Fist privates were overheard arguing about ___"
  "a whore at the Low Lantern says a client cried about ___"
  "the bookmakers moved a line because of ___"
  "an Outer City preacher worked ___ into a sermon as a sign"
  "a lamplighter went quiet mid-sentence when someone mentioned ___"
  "a barge crew is drinking through the profit and telling everyone about ___"
  "someone paid Olma-tier coin to learn about ___ and overpaid"
  "a patriar's servant pawned something and whispered about ___"
  "graffiti near the Basilisk Gate claims ___"
  "a caravan master won't take the south road because of ___"
  "the Undercellar has a new joke and the punchline is ___"
)

for ((i=0; i<COUNT; i++)); do
  f="${frames[$((RANDOM % ${#frames[@]}))]}"
  t=$(( (RANDOM % 6) + 1 ))
  case $t in
    1|2) g="TRUE: fill ___ with a real line from state/ or gm/" ;;
    3|4) g="TWISTED: real thing from the files, one detail wrong (name, count, place)" ;;
    5|6) g="FALSE: the street invented it; play what believing it costs" ;;
  esac
  echo "d6=$t [$g]"
  echo "   $f"
done
