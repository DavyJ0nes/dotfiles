# XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"

# Editor
export EDITOR=nvim

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# GPG
export GPG_TTY=$(tty)

# Terminal
export TERM=alacritty

# Go
export GOPRIVATE="github.com/einride/*"

# Erlang/Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# NVM (fallback if not using asdf for node)
export NVM_DIR="$HOME/.nvm"

# Notes
export NOTES_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/"
export ZK_NOTEBOOK_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/zk"

# Testcontainers
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export TESTCONTAINERS_RYUK_DISABLED=true

# GCC (for native extensions)
# export CC=/opt/homebrew/Cellar/gcc/14.2.0_1/bin/gcc-14
export CC=clang
