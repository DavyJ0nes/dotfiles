#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
LANG=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist | grep "KeyboardLayout Name" | tail -1 | awk -F "=" '{print $NF}' | tr -d "; \"")

sketchybar --set $NAME icon="$LANG" label="$LANG"
