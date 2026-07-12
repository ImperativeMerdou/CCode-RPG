#!/usr/bin/env bash
# wild.sh — the land gets a vote. One roll per journey leg or camp.
#   ./wild.sh coastway     ./wild.sh cloakwood    ./wild.sh fields
#   ./wild.sh trollclaws   ./wild.sh river        ./wild.sh sea
#   ./wild.sh --list
# d12: 1-5 danger, 6-8 the land speaks, 9-11 discovery, 12 wonder.
set -euo pipefail

REGION="${1:-}"

coastway=(
  "bandits with a toll rope and a widow's math"
  "a broken caravan, wheels gone, blood dry, ledger missing"
  "press gang out of the last town, short four men, counting"
  "gnoll pack shadowing at bow range, patient"
  "two Fist deserters who know exactly what their armor is worth"
  "storm front; the road drowns by dusk"
  "a toll bridge, honest, expensive, watching"
  "carrion birds marking something a mile off the road"
  "a caravan hiring blades on the spot, no questions either way"
  "a roadside shrine to Tymora, coins nailed to the post, all still there"
  "a peddler with one true relic in a tray of fakes, and no idea which"
  "a riderless warhorse, saddle bloody, worth 200 suns, waiting for someone brave"
)
cloakwood=(
  "ettercap snares strung at neck height across the game trail"
  "wyvern circling; it has already chosen"
  "spiders the size of hounds, webs like rigging"
  "loggers' camp gone quiet, tools warm"
  "a wood-witch's fence of ribs and ribbons, gate open"
  "green dark by noon; the paths disagree with the map"
  "drums, far off, wrong rhythm for anything with two arms"
  "rain that never reaches the ground, held in the canopy, dripping lies"
  "the old Iron Throne mine mouth, chained, chains cut from inside"
  "a poacher's cache: pelts, a strongbox, a bearing on who's coming back"
  "a druid watching without blinking, deciding what Merdou is"
  "a stag, white, antlered like a cathedral, that the arrows refuse"
)
fields=(
  "barrow-wights walking their old picket line at dusk"
  "grave-robbers who saw him first and dug in"
  "skeletal cavalry, a charge that has not stopped since 1235"
  "ghouls under a too-green hill, patient as roots"
  "a revenant asking every traveler the same name"
  "fog that comes up in one breath and knows him"
  "grass over the barrows humming with old war-songs"
  "a battlefield's worth of rusted arms, one blade unrusted"
  "an unopened barrow, door stone intact, crest of a dead kingdom"
  "a Waterdeep-bound caravan paying triple for a fighter after last night"
  "a barrow already open: empty, swept, and recently lived in"
  "the ghost of a legion standing muster at dawn, saluting something in him"
)
trollclaws=(
  "two trolls, hungry, regenerating faster than doubt"
  "a troll nest in the bridge stones, tolls paid in meat"
  "hill giant, drunk on fermented mash, mean and stumbling"
  "a burned trollhunter camp: they got most of it"
  "a troll that has learned fire; it carries a wet blanket"
  "the Winding Water in flood, ford gone"
  "troll-sign everywhere and then, worse, none"
  "vultures too fat to fly"
  "the Alliance bounty stone: five heads paid this season, tally scratched"
  "a hunter who knows troll country cold and needs one more blade"
  "a hot spring cave, safe, warm, claw-marked door frame from years ago"
  "a troll skeleton, burned clean, laid out flat, arranged: a warning in grammar"
)
river=(
  "pirate skiffs in the reed bend, net across the channel"
  "a barge master short on crew and honesty both"
  "something under the hull, patient, long as the barge"
  "a lock toll doubled by men who did not build the lock"
  "river ghouls in the shallows where the drowned collect"
  "brown flood water, deadfall trunks riding it like rams"
  "fish gone from a stretch that was boiling with them"
  "a drowned man's boots on the towpath, laces tied together"
  "a sunken barge, cargo intact, marked with a coster's seal"
  "an eel-camp that pays cash for guarding the smoke racks"
  "a wedding barge, music, lanterns, and one guest watching the banks"
  "at night: Umberlee's lantern, green, under the water, moving upstream"
)
sea=(
  "pirates flying false colors until the last mile"
  "a press crew with city paper and no scruples"
  "storm with a personal grudge"
  "sahuagin at the rail at night, salt devils with knives"
  "a slaver making for the Nelanther with a full hold"
  "dead calm; water like a lid on something"
  "St. Elmo's fire in the rigging, sailors gone quiet"
  "a whale carcass, and what a whale carcass invites"
  "wreckage field: one survivor, one sealed chest, one story that doesn't add"
  "a merchantman paying blade wages for the run south"
  "an island not on the chart, smoke rising, someone's home"
  "Umberlee's price: the sea flattens for one hour and every sailor pays her in silence"
)

pick() { local -n arr=$1; local n=$(( (RANDOM % 12) )); echo "d12=$((n+1)): ${arr[$n]}"; }

case "$REGION" in
  coastway|cloakwood|fields|trollclaws|river|sea) pick "$REGION" ;;
  --list|*) echo "regions: coastway cloakwood fields trollclaws river sea"; [[ "$REGION" == "--list" ]] || exit 1 ;;
esac
