#!/usr/bin/env bash

source "$CONFIG_DIR/style/colours.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    echo "focus $NAME"
    # sketchybar --set $NAME background.drawing=on
    sketchybar --set $NAME icon.color=$BLUE
else
    echo "unfocus $NAME"
    # sketchybar --set $NAME background.drawing=off
    sketchybar --set $NAME icon.color=$YELLOW
fi
