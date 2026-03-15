# ── FZF core setup ────────────────────────────────────────────────────────────
source <(fzf --zsh)

# ── Custom FZF widgets (mirrors fzf.fish keybindings) ─────────────────────────

# Ctrl+Alt+F — fuzzy directory jump (mirrors fish: _fzf_search_directory)
_fzf_search_directory() {
  local dir
  dir=$(fd --type d --hidden --exclude .git 2>/dev/null | \
    fzf --height=50% --preview='eza --tree --level=2 --color=always {}' \
        --preview-window=right:40%)
  if [[ -n $dir ]]; then
    LBUFFER="cd $dir"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N _fzf_search_directory
bindkey -M viins '\e^F' _fzf_search_directory
bindkey -M vicmd '\e^F' _fzf_search_directory

# Ctrl+Alt+L — fuzzy git log (mirrors fish: _fzf_search_git_log)
_fzf_search_git_log() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    zle -M "Not in a git repository"
    return
  fi
  local selection
  selection=$(git log --oneline --color=always 2>/dev/null | \
    fzf --ansi --no-sort --height=60% \
        --preview='git show --stat --color=always {1}' \
        --preview-window=right:50% | \
    awk '{print $1}')
  if [[ -n $selection ]]; then
    LBUFFER+="$selection"
  fi
  zle reset-prompt
}
zle -N _fzf_search_git_log
bindkey -M viins '\e^L' _fzf_search_git_log
bindkey -M vicmd '\e^L' _fzf_search_git_log

# Ctrl+Alt+S — fuzzy git status (mirrors fish: _fzf_search_git_status)
_fzf_search_git_status() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    zle -M "Not in a git repository"
    return
  fi
  local selection
  selection=$(git -c color.status=always status --short 2>/dev/null | \
    fzf --ansi --height=50% \
        --preview='git diff --color=always -- {2} 2>/dev/null | head -100' \
        --preview-window=right:50% | \
    awk '{print $NF}')
  if [[ -n $selection ]]; then
    LBUFFER+="$selection"
  fi
  zle reset-prompt
}
zle -N _fzf_search_git_status
bindkey -M viins '\e^S' _fzf_search_git_status
bindkey -M vicmd '\e^S' _fzf_search_git_status

# Ctrl+Alt+P — fuzzy process picker (mirrors fish: _fzf_search_processes)
_fzf_search_processes() {
  local selection
  selection=$(ps -eo pid,ppid,pcpu,args | \
    fzf --height=50% --header-lines=1 | \
    awk '{print $1}')
  if [[ -n $selection ]]; then
    LBUFFER+="$selection"
  fi
  zle reset-prompt
}
zle -N _fzf_search_processes
bindkey -M viins '\e^P' _fzf_search_processes
bindkey -M vicmd '\e^P' _fzf_search_processes

# Ctrl+V — fuzzy shell variable picker (mirrors fish: _fzf_search_variables)
# Note: overrides vi-quoted-insert in insert mode
_fzf_search_variables() {
  local selection
  selection=$(set | fzf --height=50% | awk -F'=' '{print $1}')
  if [[ -n $selection ]]; then
    LBUFFER+="$selection"
  fi
  zle reset-prompt
}
zle -N _fzf_search_variables
bindkey -M viins '^V' _fzf_search_variables
# Leave vicmd ^V as vi-quoted-insert (useful there)
