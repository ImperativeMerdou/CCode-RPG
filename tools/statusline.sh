#!/usr/bin/env bash
# statusline.sh — Merdou's vitals in the status line. Reads state, prints one line.
REPO="$(cd "$(dirname "$0")/.." && pwd)"
M="$REPO/state/merdou.md"; B="$REPO/state/bounty.md"; C="$REPO/state/crew.md"

hp=$(grep -m1 '\*\*HP\*\*' "$M" 2>/dev/null | sed 's/\*\*//g; s/ //g' | grep -o 'HP[0-9]*\/[0-9]*' | head -1)
fire=$(grep -m1 'Fire' "$M" 2>/dev/null | grep -o 'Fire\*\* *[0-9]/[0-9]' | grep -o '[0-9]/[0-9]')
coin=$(grep -m1 '\*\*Coin\*\*' "$M" 2>/dev/null | sed 's/\*\*Coin\*\* *//; s/\r//')
loc=$(grep -m1 '\*\*Location\*\*' "$M" 2>/dev/null | sed 's/\*\*Location\*\* *//; s/\r//' | cut -d, -f2- | sed 's/^ //')
bounty=$(grep -m1 '| \*\*Merdou\*\*' "$B" 2>/dev/null | awk -F'|' '{print $3}' | sed 's/\*//g; s/ //g')
heat=$(grep -m1 '\*\*Heat\*\*' "$C" 2>/dev/null | grep -o '[0-9]\+' | head -1)

hp="${hp/HP/HP }"
echo "🐉 Merdou | ${hp:-HP ?} | Fire ${fire:-0/3} | ${coin:-? coin} | Bounty ${bounty:-0} | Heat ${heat:-0} | ${loc:-the Gate}"
