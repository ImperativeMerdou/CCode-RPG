#!/usr/bin/env bash
# score.sh — a heist with the serial numbers still on. Roll when he wants crime with a plan.
#   ./score.sh
set -euo pipefail

targets=(
  "a warehouse of Midsummer ale, third night unwatched, allegedly"
  "a Guild counting room between collections"
  "a patriar's pleasure barge, moored, crewed by pride"
  "a coster's strongwagon overnighting at Wyrm's Crossing"
  "a fence's back room (not Kosef's, his rival's)"
  "a Fist evidence locker with something someone wants back"
  "a temple reliquary between festivals"
  "a bookmaker's cage on fight night"
  "a smuggler's cache under a chandlery floor"
  "a lender's office where indenture papers sleep"
  "a broadsheet's print shop the night before a story runs"
  "a ship in harbor with a hold the manifest lies about"
)
guards=(
  "two toughs and a dog that knows everyone"
  "a retired Knife doing favors for old money"
  "a ward that screams (bought cheap; screams in Draconic)"
  "a rotation of bribed Fist privates, schedule for sale"
  "an insider who wants it robbed, which is its own problem"
  "nothing, visibly, which should terrify a professional"
  "a Weight-carrier, low stage, bored, dangerous"
  "locks from Amn, the good kind, needing tools or an artist"
  "the owner sleeps inside with a crossbow and insomnia"
  "a Guild seal on the door: robbing it robs the Sexton"
  "a rival crew casing it the same night"
  "kids paid a copper to scream; the whole street is an alarm"
)
prizes=(
  "coin, honest weight, boring, spendable"
  "goods needing a fence and patience"
  "papers: debts, deeds, an indenture, a name's leverage"
  "a relic that hums; Kosef won't touch it; someone will"
  "a ledger someone would kill to keep unread"
  "cargo already stolen once; the first thief wants it back"
)

echo "TARGET: ${targets[$((RANDOM % 12))]}"
echo "GUARDED BY: ${guards[$((RANDOM % 12))]}"
echo "THE PRIZE: ${prizes[$((RANDOM % 6))]}"
echo "TWIST: run ./oracle.sh twist when the job is half done"
