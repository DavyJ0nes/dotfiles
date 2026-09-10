#!/bin/bash

# Dispatch to dark/light colour scheme based on ~/.config/theme-mode
THEME_MODE=$(cat "$HOME/.config/theme-mode" 2>/dev/null || echo "dark")
if [ "$THEME_MODE" = "light" ]; then
  source "$CONFIG_DIR/style/colours-light.sh"
else
  source "$CONFIG_DIR/style/colours-dark.sh"
fi
