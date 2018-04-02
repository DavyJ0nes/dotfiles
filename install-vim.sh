#!/bin/bash
set -e

#========================================================#
# Update vim configuration files
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

ln -s "$THISDIR"/vim/vimrc "$HOME"/.vimrc
ln -s "$THISDIR"/vim/vim "$HOME"/.vim

