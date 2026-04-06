# dotfiles

Personal macOS dotfiles managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- macOS
- An internet connection

## Fresh machine setup

### 1. Install Xcode Command Line Tools

```shell
xcode-select --install
```

### 2. Install Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Clone and run the install script

```shell
git clone https://github.com/DavyJ0nes/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:

- Create standard home directories (`~/go`, `~/elixir`, etc.)
- Install all packages, casks, and fonts via `brew bundle` (see `Brewfile`)
- Symlink dotfiles into place with `stow .`
- Authenticate the GitHub CLI
- Set up OCaml via opam
- Install Go tools

## Updating dotfiles

```shell
cd ~/dotfiles
stow .
```

## Adding new packages

Add entries to `Brewfile` and run:

```shell
brew bundle
```

## Structure

| Path                 | Purpose                                    |
| -------------------- | ------------------------------------------ |
| `Brewfile`           | All Homebrew packages, casks, and fonts    |
| `install.sh`         | Bootstrap script for a fresh machine       |
| `.config/`           | App configs (neovim, tmux, starship, etc.) |
| `.zshrc` / `.zshenv` | Zsh configuration                          |
