#!/bin/bash

source "$CONFIG_DIR/style/icons.sh"
source "$CONFIG_DIR/style/colours.sh"

BATTERY_INFO="$(pmset -g batt)"

BATT_PERCENT="$(echo $BATTERY_INFO | rg -o '\d+%' | cut -d% -f1)"
CHARGING="$(echo $BATTERY_INFO | rg 'AC Power')"

sketchybar --set "${NAME}" icon.color=0xff989898

if [[ ${CHARGING} != "" ]]; then
    case ${BATT_PERCENT} in
        100) ICON="󰂅" COLOR="$GREEN" ;;
        9[0-9]) ICON="󰂋" COLOR="$GREEN" ;;
        8[0-9]) ICON="󰂊" COLOR="$GREEN" ;;
        7[0-9]) ICON="󰢞" COLOR="$GREEN" ;;
        6[0-9]) ICON="󰂉" COLOR="$YELLOW" ;;
        5[0-9]) ICON="󰢝" COLOR="$YELLOW" ;;
        4[0-9]) ICON="󰂈" COLOR="$ORANGE" ;;
        3[0-9]) ICON="󰂇" COLOR="$ORANGE" ;;
        2[0-9]) ICON="󰂆" COLOR="$RED" ;;
        1[0-9]) ICON="󰢜" COLOR="$RED" ;;
        *) ICON="󰢟"  COLOR="$RED" ;;
    esac

  sketchybar --set "${NAME}" icon="${ICON}" icon.color="${COLOR}" label=$(printf "${BATT_PERCENT}%%")
  exit 0
fi

case ${BATT_PERCENT} in
  100) ICON="󰁹" COLOR="$GREEN" ;;
  9[0-9]) ICON="󰂂" COLOR="$GREEN" ;;
  8[0-9]) ICON="󰂁" COLOR="$GREEN" ;;
  7[0-9]) ICON="󰂀" COLOR="$GREEN" ;;
  6[0-9]) ICON="󰁿" COLOR="$YELLOW" ;;
  5[0-9]) ICON="󰁾" COLOR="$YELLOW" ;;
  4[0-9]) ICON="󰁽" COLOR="$ORANGE" ;;
  3[0-9]) ICON="󰁼" COLOR="$ORANGE" ;;
  2[0-9]) ICON="󰁻" COLOR="$RED" ;;
  1[0-9]) ICON="󰁺" COLOR="$RED" ;;
  *) ICON="󰂎"  COLOR="$RED" ;;
esac

sketchybar --set "${NAME}" icon="${ICON}" icon.color="${COLOR}" label=$(printf "${BATT_PERCENT}%%")
