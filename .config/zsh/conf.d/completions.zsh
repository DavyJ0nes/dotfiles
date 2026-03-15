# ── Completion system ─────────────────────────────────────────────────────────
fpath=($HOMEBREW_PREFIX/share/zsh-completions $HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

autoload -Uz compinit
# Only rebuild .zcompdump once a day for faster startup
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

_comp_options+=(globdots)   # complete hidden files

# Completion behaviour
setopt AUTO_MENU            # show menu on second Tab press
setopt AUTO_LIST
setopt COMPLETE_IN_WORD
setopt LIST_AMBIGUOUS       # complete up to ambiguity before showing menu

zstyle ':completion:*' menu select
# Layered matching: case-insensitive → partial word → substring
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}── %d ──%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'

# cd-specific: only directories, include . and .., don't offer current dir as parent
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' special-dirs true

# ── Carapace (replaces fish's man-page completions) ────────────────────────────
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
source <(carapace _carapace zsh)

# ── Custom CLI completions ─────────────────────────────────────────────────────
command -v nothelp  &>/dev/null && source <(nothelp completion zsh)
command -v epghelper &>/dev/null && source <(epghelper completion zsh)
command -v demo-cli  &>/dev/null && source <(demo-cli completion zsh)

# ── zsh-autosuggestions (fish-style inline ghost text) ────────────────────────
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^F' autosuggest-accept        # Ctrl+F accepts suggestion
bindkey '^[[C' autosuggest-accept      # Right arrow also accepts suggestion
# Tab is left as expand-or-complete (default) so cd <Tab> works properly
