# set default key bindings
set -g fish_key_bindings fish_default_key_bindings

# Source Multi-function files
source ~/.config/fish/functions/_aliases.fish

set -Ux TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE /var/run/docker.sock
set -Ux TESTCONTAINERS_RYUK_DISABLED true

set -Ux CC /opt/homebrew/Cellar/gcc/14.2.0_1/bin/gcc-14
set -Ux GPG_TTY $(tty)
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux EDITOR nvim
set -Ux TERM alacritty

set -Ux GOBIN $HOME/go/bin
set -Ux GOPATH $(go env GOPATH)
set -Ux GOPRIVATE "github.com/einride/*"
