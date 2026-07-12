#!/usr/bin/env bash
# roll.sh — dice. The GM does not invent numbers.
#   ./roll.sh 1d20+3 --label "Intimidation"
#   ./roll.sh 1d20 --advantage
#   ./roll.sh 2d6+2 --label "Cleaver"
#   ./roll.sh 1d20+6 --hidden --label "assassin stealth"
set -euo pipefail

EXPR="${1:-}"; shift || true
LABEL=""; ADV=0; DIS=0; HIDDEN=0; DC=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --label) LABEL="${2:-}"; shift 2 ;;
    --advantage) ADV=1; shift ;;
    --disadvantage) DIS=1; shift ;;
    --hidden) HIDDEN=1; shift ;;
    --dc) DC="${2:-}"; shift 2 ;;
    *) shift ;;
  esac
done

if [[ -z "$EXPR" ]]; then
  echo "usage: roll.sh NdM[+K] [--label X] [--advantage|--disadvantage] [--hidden]"
  exit 1
fi

if [[ ! "$EXPR" =~ ^([0-9]+)d([0-9]+)([+-][0-9]+)?$ ]]; then
  echo "bad expression: $EXPR"
  exit 1
fi

N="${BASH_REMATCH[1]}"
S="${BASH_REMATCH[2]}"
MOD="${BASH_REMATCH[3]:-+0}"

ROLLS=()
for ((i=0; i<N; i++)); do
  ROLLS+=( $(( (RANDOM % S) + 1 )) )
done

BASE=0
for r in "${ROLLS[@]}"; do BASE=$((BASE + r)); done
DETAIL="${ROLLS[*]}"

if [[ "$N" -eq 1 && "$S" -eq 20 && ( $ADV -eq 1 || $DIS -eq 1 ) ]]; then
  FIRST="${ROLLS[0]}"
  SECOND=$(( (RANDOM % 20) + 1 ))
  if [[ $ADV -eq 1 ]]; then
    BASE=$(( FIRST > SECOND ? FIRST : SECOND ))
    DETAIL="adv $FIRST / $SECOND"
  else
    BASE=$(( FIRST < SECOND ? FIRST : SECOND ))
    DETAIL="dis $FIRST / $SECOND"
  fi
fi

TOTAL=$(( BASE + MOD ))

if [[ $HIDDEN -eq 1 ]]; then
  echo "$TOTAL"
  exit 0
fi

OUTCOME=""
if [[ -n "$DC" ]]; then
  if (( TOTAL >= DC )); then OUTCOME=" vs DC $DC: SUCCESS"; else OUTCOME=" vs DC $DC: FAIL"; fi
fi

if [[ -n "$LABEL" ]]; then
  printf '%s | %s: [%s] %s = %s%s\n' "$LABEL" "$EXPR" "$DETAIL" "$MOD" "$TOTAL" "$OUTCOME"
else
  printf '%s: [%s] %s = %s%s\n' "$EXPR" "$DETAIL" "$MOD" "$TOTAL" "$OUTCOME"
fi

if [[ "$N" -eq 1 && "$S" -eq 20 ]]; then
  [[ $BASE -eq 20 ]] && echo "NAT 20"
  [[ $BASE -eq 1 ]] && echo "NAT 1"
fi
exit 0
