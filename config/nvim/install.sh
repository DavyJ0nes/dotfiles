#!/bin/bash
set -e

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
ln -s $PWD/custom ~/.config/nvim/lua/custom
