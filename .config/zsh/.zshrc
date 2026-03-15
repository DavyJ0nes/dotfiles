# ── zshrc ─────────────────────────────────────────────────────────────────────
# Mirrors the fish config structure: source conf.d files in order.
# ZDOTDIR is set to this directory via ~/.zshenv

# Uncomment to profile startup time:
# zmodload zsh/zprof

CONF="$ZDOTDIR/conf.d"

source "$CONF/paths.zsh"
source "$CONF/variables.zsh"
source "$CONF/options.zsh"
source "$CONF/completions.zsh"
source "$CONF/fzf.zsh"
source "$CONF/aliases.zsh"
source "$CONF/functions.zsh"
source "$CONF/tools.zsh"      # starship + syntax-highlighting go last

# Uncomment to see startup profile:
# zprof
