#!/usr/bin/env bash
# event.sh — the world moves whether he shows up or not.
#   ./event.sh            one world beat (d66)
#   ./event.sh 2          two beats
# Beats that touch existing threads, clocks or NPCs tick them. Write every beat to world.md.
set -euo pipefail
COUNT="${1:-1}"

events=(
  "a Guild kingpin dies; the succession is not clean"
  "the Fist hangs three men at the Basilisk Gate; one crowd, three lessons"
  "a patriar scandal hits the broadsheets: money, a body, a name misspelled"
  "grain barges late; bread doubles; the Outer City counts its knives"
  "a ship limps in with survivors of something they describe badly"
  "the Zhentarim open a new front business; everyone knows in a tenday"
  "a refugee racket and the Guild trade corpses over a market street"
  "a dragon is sighted far off; wrong color for the region; taverns argue"
  "a Red Wizard enclave agent buys something that should not be for sale"
  "the Watch closes the Upper City gates for a funeral; commerce snarls"
  "a caravan arrives short six guards and one wagon; the story shifts each telling"
  "press gangs work the docks; the Fist needs bodies for something north"
  "a temple festival floods the streets: pickpocket harvest, Fist overtime"
  "an execution goes wrong; the crowd remembers whose knot slipped"
  "a mark on the Board gets collected; the collector drinks free for a tenday"
  "a new bounty posts big enough that hunters come off the roads for it"
  "the Elfsong's dead voice sings a song nobody has heard before; the Gate talks"
  "a kingpin raises protection rates on a stretch that cannot pay"
  "a plague scare in the stockyards; quarantine chalk, honest and not"
  "a noble wedding; contracts, feasts, and every fence in the city stocked"
  "the river runs strange for a day; Umberlee's clergy collect double"
  "a fighting pit gets raided; not Jhessail's; margins tighten everywhere"
  "two Fist patrols brawl each other; discipline hearings; a vacuum on a route"
  "a Harper is found floating; nobody claims the body; three factions attend anyway"
  "a smith sells a masterwork blade to an unknown buyer; the blade resurfaces later"
  "the Undercellar closes a door that has always been open"
  "a lamplighter goes missing; the Guild's eyes have a blind spot for a tenday"
  "a foreign coster undercuts the docks; honest men get hungry; hungry men get brave"
  "rumor: Nine-Fingers took a meeting she left angry"
  "a child prophet in Twin Songs draws crowds; half mock, half kneel"
  "storm wrecks a warehouse roof; salvage rights argued with crowbars"
  "an old gang name resurfaces on fresh graffiti; the old men go quiet"
  "a mercenary company musters outside the walls, hiring, vague about the work"
  "the Board reprints: somebody's number doubled overnight and nobody says why"
  "a god's omen, small and public: birds, blood in a fountain, a bell that rings itself"
  "quiet tenday; prices settle; everyone waits for the other shoe"
)

for ((i=0; i<COUNT; i++)); do
  d1=$(( (RANDOM % 6) + 1 )); d2=$(( (RANDOM % 6) + 1 ))
  idx=$(( (d1 - 1) * 6 + (d2 - 1) ))
  echo "d66=$d1$d2: ${events[$idx]}"
done
