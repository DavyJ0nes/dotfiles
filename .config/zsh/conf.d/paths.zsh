# Homebrew
export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CELLAR=/opt/homebrew/Cellar
export HOMEBREW_REPOSITORY=/opt/homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man:$MANPATH"
export INFOPATH="/opt/homebrew/share/info:$INFOPATH"

# User bins
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# GNU make (macOS ships with v3.81)
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# Elixir mix escripts
export PATH="$HOME/.mix/escripts:$PATH"

# Go
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export PATH="$GOPATH/bin:$PATH"

# K8s
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# FZF / FD
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
