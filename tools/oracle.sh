#!/usr/bin/env bash
# oracle.sh — the GM asks the dice, not his habits.
#   ./oracle.sh likely "does the Fist patrol pass before the third bell?"
#   ./oracle.sh even "is the warehouse guarded tonight?"
#   ./oracle.sh twist              (force a twist roll)
# Odds: sure(90) likely(75) even(50) unlikely(25) desperate(10)
# Doubles on the d100 (11,22,...,99) mean the answer arrives WITH a twist.
set -euo pipefail

ODDS="${1:-}"; QUESTION="${2:-}"

twists=(
  "an old face returns with a new want"
  "a named NPC acts on their want, now, on screen"
  "a clock ticks where nobody is looking"
  "a faction man is watching and takes notes"
  "the weather turns and costs someone"
  "coin appears where it should not be"
  "someone lies and the lie will surface later: write a thread"
  "a bystander gets involved, name them with name.sh"
  "the mark on his skin stirs: heat, itch, a word almost legible"
  "a debt is called in, his or someone else's"
  "violence starts nearby that has nothing to do with him. Yet"
  "a rumor about Merdou reaches the wrong ears, exaggerated"
  "something breaks: a weapon, a floor, a promise"
  "an animal, a child or a drunk sees what no one else does"
  "the Guild's ledger notices a number it does not like"
  "a broadsheet writer smells a story"
  "a god's small coincidence: Tymora or Hoar, GM's read"
  "an exit closes; a worse one opens"
  "someone attractive complicates a simple thing"
  "the thing he wanted is already gone, taken minutes ago"
)

roll_twist() { echo "TWIST: ${twists[$((RANDOM % ${#twists[@]}))]}"; }

if [[ "$ODDS" == "twist" ]]; then roll_twist; exit 0; fi

# scene oracle: does the next scene start as planned?
if [[ "$ODDS" == "scene" ]]; then
  R=$(( (RANDOM % 10) + 1 ))
  if   (( R <= 6 )); then echo "scene d10=$R -> as planned"
  elif (( R <= 8 )); then echo "scene d10=$R -> ALTERED: same scene, one element changed (who, where, mood)"
  else                    echo "scene d10=$R -> INTERRUPT: something else happens first"; roll_twist
  fi
  exit 0
fi

case "$ODDS" in
  sure) T=90 ;; likely) T=75 ;; even) T=50 ;; unlikely) T=25 ;; desperate) T=10 ;;
  *) echo "usage: oracle.sh sure|likely|even|unlikely|desperate \"question\"  (or: oracle.sh twist)"; exit 1 ;;
esac

R=$(( (RANDOM % 100) + 1 ))
if   (( R <= T / 5 ));            then ANS="YES, AND (stronger than asked)"
elif (( R <= T ));                then ANS="yes"
elif (( R > 100 - (100-T)/5 ));   then ANS="NO, AND (worse than asked)"
else                                   ANS="no"
fi

[[ -n "$QUESTION" ]] && echo "Q: $QUESTION"
echo "odds=$ODDS d100=$R -> $ANS"

# doubles = the world adds its own opinion
if (( R % 11 == 0 )); then roll_twist; fi
