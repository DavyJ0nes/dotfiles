#!/bin/bash
set -e

## -- Homebrew ----------------------------------------------------------------
echo "installing Homebrew packages..."
brew install adr-tools
brew install awscli
brew install bash
brew install bat
brew install blueutil
brew install cmake
brew install coreutils
brew install diffutils
brew install docker-compose
brew install elixir
brew install exercism
brew install eza
brew install fd
brew install fish
brew install fisher
brew install fzf
brew install gcc
brew install gh
brew install git
brew install gnu-sed
brew install gnupg
brew install go
brew install gofumpt
brew install golangci-lint
brew install golines
brew install grep
brew install jq
brew install kn
brew install ko
brew install kubernetes-cli
brew install lazygit
brew install make
brew install mdcat
brew install minikube
brew install neovim
brew install pinentry-mac
brew install podman
brew install pyenv
brew install ripgrep
brew install shellcheck
brew install shfmt
brew install socat
brew install stow
brew install switchaudio-osx
brew install task
brew install taskwarrior-tui
brew install tfenv
brew install tmux
brew install tmuxinator
brew install tree
brew install walk
brew install watch
brew install wget
brew install yq
brew install zoxide

echo "installing Homebrew casks..."

brew tap FelixKratz/formulae
brew install sketchybar

brew install --cask nikitabobko/tap/aerospace
brew install --cask alacritty
brew install --cask ghostty
brew install --cask livebook
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-lilex-nerd-font
brew install --cask font-sf-pro
brew install --cask google-chrome
brew install --cask google-cloud-sdk
brew install --cask raycast
brew install --cask sf-symbols

echo "homebrew packages installed successfully!"
## ----------------------------------------------------------------------------

## -- Dotfiles ----------------------------------------------------------------
echo "configuring dotfiles..."
stow .
echo "dotfiles configured successfully!"
## ----------------------------------------------------------------------------

## -- Fish --------------------------------------------------------------------
echo "setting up fish..."
sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"
sudo chsh -s /usr/local/bin/fish
echo "fish setup successfully!"
## ----------------------------------------------------------------------------

## -- Sketchybar --------------------------------------------------------------
echo "enabling sketchybar..."
brew services start sketchybar
echo "sketchybar enabled successfully!"
## ----------------------------------------------------------------------------

## -- Home Folders ------------------------------------------------------------
echo "setting up default folders"
cd $HOME && mkdir -p {elixir,go,scratch,tmp,work_notes}
cd $HOME && mkdir -p elixir/src
cd $HOME && mkdir -p go/{src,bin,pkg}
cd $HOME && mkdir -p go/src/github.com/{davyj0nes,fever}
## ----------------------------------------------------------------------------

## -- Git ---------------------------------------------------------------------
echo "setting up git config..."
gh auth login
gh config set git_protocol ssh
gh config set editor nvim
gh auth setup-git
## ----------------------------------------------------------------------------

echo "installations complete!"

echo "now clone notes repo and check that taskwarrior is working"

while true; do
    read -p "Type 'yes' to continue: " input
    if [ "$input" == "yes" ]; then
        echo "Continuing..."
        break
    else
        echo "Please type 'yes' to continue."
    fi
done

echo "adding remaining tasks to taskwarrior..."

task add "Update Caps Lock to Escape" due:today
task add "Install Slack" due:today
task add "Install Keymap" due:today
task add "Hide Dock and menu bar" due:today
task add "Rearrange dock applications" due:today
task add "Set background image" due:today
task add "Restore raycast settings" due:today
task add "Sort out raycast shortcut" due:today

echo "done..."
