# ── History ───────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ── Navigation ────────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CDABLE_VARS

# ── Globbing ──────────────────────────────────────────────────────────────────
# setopt EXTENDED_GLOB
setopt NO_CASE_GLOB

# ── UX ────────────────────────────────────────────────────────────────────────
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
setopt CORRECT                # spelling correction on commands
setopt NO_BEEP

# ── Vi key bindings ───────────────────────────────────────────────────────────
bindkey -v
export KEYTIMEOUT=1           # reduce mode switch lag to 10ms

# Restore useful emacs-style bindings in insert mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history

# Vi mode indicator in right prompt (works alongside starship)
function _vi_mode_indicator() {
  case ${KEYMAP} in
    vicmd) echo '%F{yellow}[N]%f' ;;
    *) echo '' ;;
  esac
}

function zle-keymap-select() {
  RPROMPT=$(_vi_mode_indicator)
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init() {
  RPROMPT=''
  zle reset-prompt
}
zle -N zle-line-init
