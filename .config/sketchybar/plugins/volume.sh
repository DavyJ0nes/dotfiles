#!/bin/bash

source "$CONFIG_DIR/style/icons.sh"
WIDTH=100


function get_icon () {
  if [ "$(SwitchAudioSource -c)" != "MacBook Pro Speakers" ]; then
    echo $ICON_HEADPHONES
    return
  fi

  case $1 in
    [6-9][0-9]|100) echo $VOLUME_100
    ;;
    [3-5][0-9]) echo $VOLUME_66
    ;;
    [1-2][0-9]) echo $VOLUME_33
    ;;
    [1-9]) echo $VOLUME_10
    ;;
    0) echo $VOLUME_0
    ;;
    *) echo $VOLUME_100
  esac
}

volume_change() {
  ICON=$(get_icon $INFO)

  sketchybar --set volume_icon label=$ICON \
             --set $NAME slider.percentage=$INFO \
             --set $NAME label.drawing=off


  INITIAL_WIDTH="$(sketchybar --query $NAME | jq -r ".slider.width")"
  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    sketchybar --animate tanh 30 --set $NAME slider.width=$WIDTH
  fi

  sleep 2

  # Check wether the volume was changed another time while sleeping
  FINAL_PERCENTAGE="$(sketchybar --query $NAME | jq -r ".slider.percentage")"
  if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
    sketchybar --animate tanh 30 --set $NAME slider.width=0
  fi
}

mouse_clicked() {
  osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
  "volume_change") volume_change
  ;;
  "mouse.clicked") mouse_clicked
  ;;
esac
