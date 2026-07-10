#!/bin/bash
#
# Pomodoro focus timer — github.com/davyj0nes/timer
#
# The `timer` daemon drives this item directly: while a session runs it pushes
# the phase glyph (icon), a "MM:SS n/total" label, and drawing=on every second,
# then pushes drawing=off on stop. There is deliberately no update_freq/script
# here — the daemon is the sole updater. Clicking toggles pause/resume.

# Resolve the binary at load time so click_script has an absolute path
# regardless of sketchybar's runtime PATH.
TIMER_BIN="$(command -v timer 2>/dev/null || echo "$HOME/go/bin/timer")"

timer=(
  icon=󰔟                        # nf-md-timer; daemon swaps per phase (󰅶 break, 󱁠 long break)
  icon.font="$FONT:Regular:16.0"
  icon.color=$RED
  label.font="$FONT:Semibold:13.0"
  label.color=$LABEL_COLOR
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  drawing=off
  click_script="$TIMER_BIN toggle"
)

sketchybar --add item timer right \
           --set timer "${timer[@]}"
