#!/bin/bash
set -e

echo "==> Starting dotfiles setup..."

## -- Xcode Command Line Tools ------------------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "    Re-run this script after the installation completes."
  exit 0
fi
echo "==> Xcode Command Line Tools already installed"
## ----------------------------------------------------------------------------

## -- Homebrew ----------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
echo "==> Homebrew already installed"
## ----------------------------------------------------------------------------

## -- Clone dotfiles ----------------------------------------------------------
DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "==> Cloning dotfiles..."
  git clone https://github.com/DavyJ0nes/dotfiles.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"
## ----------------------------------------------------------------------------

## -- Home Folders ------------------------------------------------------------
echo "==> Creating default folders..."
mkdir -p "$HOME"/{elixir,go,scratch,tmp,work_notes}
mkdir -p "$HOME/elixir/src"
mkdir -p "$HOME/go"/{src,bin,pkg}
mkdir -p "$HOME/go/src/github.com/davyj0nes"
## ----------------------------------------------------------------------------

## -- Homebrew Packages (via Brewfile) ----------------------------------------
echo "==> Installing Homebrew packages via Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "==> Homebrew packages installed"
## ----------------------------------------------------------------------------

## -- Dotfiles (stow) ---------------------------------------------------------
echo "==> Configuring dotfiles with stow..."
stow .
echo "==> Dotfiles configured"
## ----------------------------------------------------------------------------

## -- GitHub CLI auth ---------------------------------------------------------
echo "==> Setting up GitHub CLI..."
gh auth login
gh config set git_protocol ssh
gh config set editor nvim
gh auth setup-git
## ----------------------------------------------------------------------------

## -- OCaml -------------------------------------------------------------------
echo "==> Setting up OCaml..."
opam init -a
opam install ocaml-lsp-server odoc ocamlformat utop
## ----------------------------------------------------------------------------

## -- Go tools ----------------------------------------------------------------
echo "==> Installing Go tools..."
go install github.com/rhysd/actionlint/cmd/actionlint@latest
go install golang.org/x/tools/cmd/callgraph@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest
go install github.com/davyj0nes/partner-validate@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
go install github.com/abice/go-enum@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/abenz1267/gomvp@latest
go install golang.org/x/tools/cmd/gonew@latest
go install golang.org/x/tools/cmd/gorename@latest
go install github.com/cweill/gotests/gotests@latest
go install gotest.tools/gotestsum@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install github.com/koron/iferr@latest
go install github.com/josharian/impl@latest
go install github.com/tmc/json-to-struct@latest
go install go.uber.org/mock/mockgen@latest
go install github.com/davyj0nes/nothelp@latest
go install github.com/kyoh86/richgo@latest
echo "==> Go tools installed"
## ----------------------------------------------------------------------------

## -- Sketchybar --------------------------------------------------------------
echo "==> Starting sketchybar..."
brew services start sketchybar
## ----------------------------------------------------------------------------

## -- Manual steps reminder ---------------------------------------------------
echo ""
echo "==> Setup complete! A few manual steps remain:"
echo ""
echo "    [ ] Restore Raycast settings"
echo "    [ ] Set Caps Lock → Escape in System Settings > Keyboard"
echo "    [ ] Install Slack (App Store or slack.com)"
echo "    [ ] Install Keymapp (keymapp.app)"
echo "    [ ] Set desktop background"
echo "    [ ] Hide Dock and menu bar"
echo ""
