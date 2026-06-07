#!/bin/bash

source "$CONFIG_DIR/style/icons.sh"

##### Adding aerospace workspace numbers
sketchybar --add event aerospace_workspace_change

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

MAX_SPACE=7

for sid in $(aerospace list-workspaces --all); do
    # Skip workspaces beyond the max (numeric) or named ones
    case "$sid" in
      [0-9]*) [[ "$sid" -gt "$MAX_SPACE" ]] && continue ;;
      z) ;;
      *) continue ;;
    esac
    case "$sid" in
      e) icon="$ICON_MAIL" ;;
      z) icon="$ICON_FILE" ;;
      *) icon="${ICONS_SPACES[$sid]}" ;;
    esac
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        padding_left=2 \
        padding_right=2 \
        icon.font="$FONT:Bold:19.0" \
        icon="$icon" \
        icon.color=$YELLOW \
        background.corner_radius=3 \
        background.height=33 \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
