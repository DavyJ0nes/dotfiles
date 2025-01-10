#!/bin/bash

datetime=(
  icon=cal
  icon.font="$FONT:Black:15.0"
  label.font="$FONT:Black:15.0"
  icon.padding_right=0
  label.width=45
  label.align=right
  padding_left=15
  padding_right=10
  update_freq=30
  script="$PLUGIN_DIR/datetime.sh"
)

sketchybar --add item datetime right       \
           --set datetime "${datetime[@]}" \
           --subscribe datetime system_woke
