#!/bin/bash
set -e

# FileCopyFunc abstracts a copy loop for reusability
FileCopyFunc() {
  ARRAY=$1
  DIR=$2
  for f in "${ARRAY[@]}"; do
    cp "$HOME/$DIR/$f" "./$DIR/$f"
    echo "Copied $f"
  done
  return 0
}

#####      COPYING OVER     #####
# Copy Vim Files
echo "-- Copying Vim Files"
cp "$HOME/.vimrc" vim/.vimrc
cp -r "$HOME/.vim" vim/.vim
echo "-- Finished Copying Vim Files"

# Copy tmux Files
echo "-- Copying Tmux Files"
files=(.tmux.conf /tmux-powerlinerc)
FileCopyFunc "${files[@]}" "tmux"
cp -r "$HOME/.tmux" tmux/.tmux
cp -r "$HOME/.tmuxinator" tmux/.tmuxinator
echo "-- Finished Copying Tmux Files"

# Copy ZSH Files
echo "-- Copying ZSH Files"
cp "$HOME/.zshrc" zsh/.zshrc
cp -r "$HOME/.oh-my-zsh" zsh/.oh-my-zsh
echo "-- Finished Copying ZSH Files"

# Copy Bin Files
echo "-- Copying bin files"
files=(backup dnd dpg ex-pg exenv gitql ip4 json-csv pingtime start timeconv)
FileCopyFunc "${files[@]}" "bin"
echo "-- Finished bin files"

echo "-- COMPLETE --"
exit 0

