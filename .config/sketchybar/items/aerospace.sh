#!/bin/bash

source "$CONFIG_DIR/style/icons.sh"

##### Adding aerospace workspace numbers
sketchybar --add event aerospace_workspace_change

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        padding_left=2 \
        padding_right=2 \
        icon.font="$FONT:Bold:19.0" \
        icon=${ICONS_SPACES[$sid]} \
        icon.color=$YELLOW \
        background.corner_radius=3 \
        background.height=33 \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
