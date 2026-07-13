#!/usr/bin/env bash
# name.sh — names come from dice and canon, never from the model's habits.
# Banks are Player's Handbook ethnic lists plus grounded Baldurian street names.
#
#   ./name.sh baldurian f          one Lower City woman, first + street surname
#   ./name.sh chondathan m 3       three options, take the first that doesn't collide
#   ./name.sh orc f                pit fighters, dock muscle
#   ./name.sh tiefling m           infernal line
#   ./name.sh virtue               tiefling virtue name
#   ./name.sh epithet              street moniker ("the Anvil")
#   ./name.sh --list               all banks
#
# LAW: take the FIRST result. Reroll only on collision with an existing name.
set -euo pipefail

CULTURE="${1:-}"; SEX="${2:-}"; COUNT="${3:-1}"

# virtue/epithet take no sex: ./name.sh epithet 3 means count=3
if [[ "$CULTURE" == "virtue" || "$CULTURE" == "epithet" ]] && [[ "$SEX" =~ ^[0-9]+$ ]]; then
  COUNT="$SEX"; SEX=""
fi

# Human ethnic banks (PHB). Real-world roots keep them believable:
# chondathan=Old English, illuskan=Norse, calishite=Arabic,
# damaran=Slavic, rashemi=steppe, turami=Mediterranean.
chondathan_m=(Darvin Dorn Evendur Gorstag Grim Helm Malark Morn Randal Stedd)
chondathan_f=(Arveene Esvele Jhessail Kerri Lureene Miri Rowan Shandri Tessele)
chondathan_s=(Amblecrown Buckman Dundragon Evenwood Greycastle Tallstag)
illuskan_m=(Ander Blath Bran Frath Geth Lander Luth Malcer Stor Taman Urth)
illuskan_f=(Amafrey Betha Cefrey Kethra Mara Olga Silifrey Westra)
illuskan_s=(Brightwood Helder Hornraven Lackman Stormwind Windrivver)
calishite_m=(Aseir Bardeid Haseid Khemed Mehmen Sudeiman Zasheir)
calishite_f=(Atala Ceidil Hama Jasmal Meilil Seipora Yasheira Zasheida)
calishite_s=(Basha Dumein Jassan Khalid Mostana Pashar Rein)
damaran_m=(Bor Fodel Glar Grigor Igan Ivor Kosef Mival Orel Pavel Sergor)
damaran_f=(Alethra Kara Katernin Mara Natali Olma Tana Zora)
damaran_s=(Bersk Chernin Dotsk Kulenov Marsk Nemetsk Shemov Starag)
rashemi_m=(Borivik Faurgar Jandar Kanithar Madislak Ralmevik Shaumar Vladislak)
rashemi_f=(Fyevarra Hulmarra Immith Imzel Navarra Shevarra Tammith Yuldra)
rashemi_s=(Chergoba Dyernina Iltazyara Murnyethara Stayanoga Ulmokina)
turami_m=(Anton Diero Marcon Pieron Rimardo Romero Salazar Umbero)
turami_f=(Balama Dona Faila Jalana Luisa Marta Quara Selise Vonda)
turami_s=(Agosto Astorio Calabra Domine Falone Marivaldi Pisacar Ramondo)

# Nonhuman banks (PHB).
dwarf_m=(Adrik Baern Barendd Brottor Dain Darrak Eberk Einkil Fargrim Flint Gardain Harbek Kildrak Morgran Orsik Rangrim Rurik Taklinn Thoradin Tordek Traubon Travok Ulfgar Veit Vondal)
dwarf_f=(Amber Artin Audhild Bardryn Dagnal Diesa Eldeth Falkrunn Finellen Gunnloda Gurdis Helja Hlin Kathra Kristryd Ilde Liftrasa Mardred Riswynn Sannl Torbera Torgga Vistra)
dwarf_s=(Balderk Battlehammer Brawnanvil Dankil Fireforge Frostbeard Gorunn Holderhek Ironfist Loderr Lutgehr Rumnaheim Strakeln Torunn Ungart)
elf_m=(Adran Aelar Aramil Arannis Aust Beiro Berrian Carric Enialis Erdan Erevan Galinndan Hadarai Heian Himo Immeral Ivellios Laucian Mindartis Paelias Peren Quarion Riardon Rolen Soveliss Thamior Tharivol Theren Varis)
elf_f=(Adrie Althaea Anastrianna Andraste Antinua Bethrynna Birel Caelynn Drusilia Enna Felosial Ielenia Jelenneth Leshanna Lia Meriele Naivara Quelenna Quillathe Sariel Shava Silaqui Theirastra Thia Vadania Valanthe Xanaphia)
elf_s=(Amakiir Amastacia Galanodel Holimion Ilphelkiir Liadon Meliamne Nailo Siannodel Xiloscient)
halfling_m=(Alton Ander Cade Corrin Eldon Errich Finnan Garret Lindal Lyle Merric Milo Osborn Perrin Reed Roscoe Wellby)
halfling_f=(Andry Bree Callie Cora Euphemia Jillian Kithri Lavinia Lidda Merla Nedda Paela Portia Shaena Trym Vani Verna)
halfling_s=(Brushgather Goodbarrel Greenbottle Hilltopple Leagallow Tealeaf Thorngage Tosscobble Underbough)
orc_m=(Dench Feng Gell Henk Holg Imsh Keth Krusk Mhurren Ront Shump Thokk)
orc_f=(Baggi Emen Engong Kansif Myev Neega Ovak Ownka Shautha Sutha Vola Volen Yevelda)
tiefling_m=(Akmenos Amnon Barakas Damakos Ekemon Iados Kairon Leucis Melech Mordai Morthos Pelaios Skamos Therai)
tiefling_f=(Akta Anakis Bryseis Criella Damaia Ea Kallista Lerissa Makaria Nemeia Orianna Phelaia Rieta)
virtue_x=(Art Carrion Chant Creed Despair Excellence Fear Glory Hope Ideal Music Nowhere Open Poetry Quest Random Reverence Sorrow Temerity Torment Weary)

# Baldurian street surnames. Trade, place, injury. The Lower City names its own.
street_s=(Netter Cooper Tarhand Saltwell Bilgewater Stormshore Wharfling Eelmonger Ropewalk Gullfeed Barrelwright Mudfoot Threefinger Coalgate Herringbone Slipdock Baitwell Chainman Lampblack Ashquay)

# Epithets. Earned, not decorative.
epithet_x=(Anvil Bellows Eel Hook Ledger Mallet Gull Tar Brick Cleaver Lantern Ferret Widow Sexton Cudgel Bonesaw Tollman Magpie Flint Gaff)

pick() { local -n arr=$1; echo "${arr[$((RANDOM % ${#arr[@]}))]}"; }

list_banks() {
  echo "human: chondathan illuskan calishite damaran rashemi turami (m/f, surname auto)"
  echo "other: dwarf elf halfling orc tiefling (m/f)"
  echo "mixes: baldurian (m/f: mixed human first + street surname)"
  echo "extra: virtue, epithet (no sex argument)"
}

if [[ "$CULTURE" == "--list" || -z "$CULTURE" ]]; then list_banks; exit 0; fi

case "$CULTURE" in
  chondathan|illuskan|calishite|damaran|rashemi|turami|dwarf|elf|halfling|orc|tiefling|baldurian|virtue|epithet) ;;
  *) echo "unknown bank: $CULTURE"; list_banks; exit 1 ;;
esac

gen_one() {
  case "$CULTURE" in
    chondathan|illuskan|calishite|damaran|rashemi|turami)
      first=$(pick "${CULTURE}_${SEX}"); sur=$(pick "${CULTURE}_s")
      echo "$first $sur" ;;
    dwarf|elf|halfling)
      first=$(pick "${CULTURE}_${SEX}"); sur=$(pick "${CULTURE}_s")
      echo "$first $sur" ;;
    orc|tiefling)
      pick "${CULTURE}_${SEX}" ;;
    baldurian)
      cultures=(chondathan illuskan turami damaran)
      c="${cultures[$((RANDOM % 4))]}"
      first=$(pick "${c}_${SEX}"); sur=$(pick street_s)
      echo "$first $sur" ;;
    virtue) pick virtue_x ;;
    epithet) echo "the $(pick epithet_x)" ;;
  esac
}

# Multi-option pulls give distinct names or the "three options" law is a lie.
seen=$'\n'
emitted=0
attempts=0
while (( emitted < COUNT )); do
  attempts=$((attempts+1))
  n="$(gen_one)"
  if [[ "$seen" == *$'\n'"$n"$'\n'* ]] && (( attempts < COUNT * 25 )); then
    continue
  fi
  seen+="$n"$'\n'
  emitted=$((emitted+1))
  echo "$n"
done
