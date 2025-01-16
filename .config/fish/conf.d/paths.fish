# Setting up the Path
set -e fish_user_paths

# Homebrew config
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -q PATH; or set PATH ''
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
set -g fish_user_paths $HOMEBREW_PREFIX/bin $fish_user_paths
set -g fish_user_paths $HOME/bin $fish_user_paths

# Homebrew make - gmake - MacOS ships with v3.81
set -g fish_user_paths /opt/homebrew/opt/make/libexec/gnubin $fish_user_paths

# GO
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

# FZF and FD helpers for NeoVim
set -x FZF_DEFAULT_COMMAND "fd --type f"
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
