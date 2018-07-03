#!/bin/bash
set -e

#========================================================#
# Update vim and zsh configuration files
# This is a temporary fix while I update my config files
# 2018
#========================================================#
 
# print_usage() {
#  echo "usage: $1 <arg>"
#  echo ""
#  echo "Update Config Files"
#  echo " - arg: command line arguement for script"
# }
 
# VARIABLES
# arg=$1

# SYMLINK VIM FILES
THISDIR=$(pwd)

## Symlink vim files
echo "Linking vim files"

if ! ls "$HOME/.vimrc" > /dev/null 2>&1; then
  ln -s "$THISDIR"/vim/vimrc "$HOME"/.vimrc
fi

if ! ls "$HOME/.vim" > /dev/null 2>&1; then
  ln -s "$THISDIR"/vim/vim "$HOME"/.vim
fi

## Symlink zsh files
echo "Linking zsh files"

if ! ls "$HOME/.zshrc" > /dev/null 2>&1; then
  ln -s "$THISDIR"/zsh/zshrc "$HOME"/.zshrc
fi

if ! ls "$HOME/.oh-my-zsh" > /dev/null 2>&1; then
  ln -s "$THISDIR"/zsh/oh-my-zsh "$HOME"/.oh-my-zsh
fi

