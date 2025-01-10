#!/bin/bash

input_source=(
  padding_right=7
  label.width=0
  update_freq=5
  script="$PLUGIN_DIR/input_source.sh"
)

sketchybar --add item input_source right \
           --set input_source "${input_source[@]}" \
           --subscribe input_source
