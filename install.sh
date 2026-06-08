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


## -- Home Folders ------------------------------------------------------------
echo "==> Creating default folders..."
mkdir -p "$HOME"/{elixir,go,rust,scratch,tmp,work_notes}
mkdir -p "$HOME/elixir/src"
mkdir -p "$HOME/go"/{src,bin,pkg}
mkdir -p "$HOME/go/src/github.com/davyj0nes"
mkdir -p "$HOME/rust/davyj0nes"
## ----------------------------------------------------------------------------

## -- Homebrew Packages (via Brewfile) ----------------------------------------
echo "==> Installing Homebrew packages via Brewfile..."
brew bundle
echo "==> Homebrew packages installed"
## ----------------------------------------------------------------------------

## -- Dotfiles (stow) ---------------------------------------------------------
# Stow must run before `mise install` so the conf.d/*.toml files are in place
# under ~/.config/mise/ for mise to pick up.
echo "==> Configuring dotfiles with stow..."
stow .
echo "==> Dotfiles configured"
## ----------------------------------------------------------------------------

## -- Mise-managed tools ------------------------------------------------------
# Installs everything pinned in ~/.config/mise/conf.d/*.toml: language
# runtimes, k8s/IaC CLIs, and Go developer tools.
echo "==> Installing mise-managed tools..."
mise install
echo "==> mise tools installed"
## ----------------------------------------------------------------------------

## -- GitHub CLI auth ---------------------------------------------------------
echo "==> Setting up GitHub CLI..."
gh auth login
gh config set git_protocol ssh
gh config set editor nvim
gh auth setup-git
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
