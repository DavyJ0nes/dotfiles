# ── Rust ──────────────────────────────────────────────────────────────────────
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ── UV (Python) ───────────────────────────────────────────────────────────────
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# ── Direnv ────────────────────────────────────────────────────────────────────
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# ── Zoxide (replaces z plugin) ────────────────────────────────────────────────
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# ── Atuin (history) ───────────────────────────────────────────────────────────
[[ -f "$HOME/.atuin/bin/env" ]] && source "$HOME/.atuin/bin/env"
command -v atuin &>/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

# ── Starship prompt ───────────────────────────────────────────────────────────
command -v starship &>/dev/null && eval "$(starship init zsh)"

# ── Google Cloud SDK ──────────────────────────────────────────────────────────
# if [[ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]]; then
#   source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
#   autoload -Uz bashcompinit && bashcompinit
#   source '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'
# fi

# ── opam (OCaml) ──────────────────────────────────────────────────────────────
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" &>/dev/null

# ── AWS completions ───────────────────────────────────────────────────────────
if command -v aws_completer &>/dev/null; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

# ── zsh-syntax-highlighting (must be sourced last) ────────────────────────────
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
