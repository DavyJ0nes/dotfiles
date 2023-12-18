# dotfiles

## Description

This is a selection of my dot files for neovim, zsh and tmux.

## Installation

### Colour Scheme

Install [Catpuccin](https://github.com/catppuccin/catppuccin) everywhere.

### Neovim

For Neovim I'm using [NvChad](https://nvchad.com) which gives a really solid
baseline configuration for using Neovim as more of an IDE.

- Install neovim with `brew install nvim`
- Run the install script in `config/neovim`, this will clone NvChad and link the
  custom configuration to the correct location.

### zsh

Am using the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin
scripts to help bootstrap my ZSH environment. 

Install that and then symlink the `.zshrc` to the home directory.

### tmux

Tmux is awesome, this requires tpm to be installed and then after symlinking
the configuration files, run `PREFIX + I` to install the dependencies.

Tmuxinator is used to prexonfigure some window setups for tmux.
Run with `mux start dev`.

# LICENSE

MIT
