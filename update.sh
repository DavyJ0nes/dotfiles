#!/bin/bash
set -e

# FileCopyFunc abstracts a copy loop for reusability
FileCopyFunc() {
  DIR=$1
  shift # remove $1 from args list
  ARRAY=($@)
  for f in "${ARRAY[@]}"; do
    rsync -avq --copy-links "$HOME/CODE/$DIR/$f" "$DIR/$f"
    echo "----- Copied $f"
  done
  return 0
}

#####      COPYING OVER     #####
echo "BEGINING COPY"
# Copy Vim Files
echo "-- Copying Vim Files"
cp "$HOME/.vimrc" vim/.vimrc
rsync -avq "$HOME/.vim" vim/.vim --exclude .git
echo "-- Finished Copying Vim Files"

# Copy tmux Files
echo "-- Copying Tmux Files"
cp "$HOME/.tmux.conf" tmux/.tmux.conf
cp "$HOME/.tmux.conf.local" tmux/.tmux.conf.local
# cp "$HOME/.tmux-powerlinerc" tmux/.tmux-powerlinerc
# rsync -avq "$HOME/.tmux" tmux/.tmux --exclude .git
# rsync -avq "$HOME/.tmuxinator" tmux/.tmuxinator --exclude .git
echo "-- Finished Copying Tmux Files"

# Copy ZSH Files
echo "-- Copying ZSH Files"
cp "$HOME/.zshrc" zsh/.zshrc
rsync -avq "$HOME/.oh-my-zsh" zsh/.oh-my-zsh --exclude .git
echo "-- Finished Copying ZSH Files"

# Copy Bin Files
echo "-- Copying bin files"
files=(aop backup dnd dpg ex-pg exenv gitql ip4 json-csv pingtime start timeconv mux docker-terraform)
FileCopyFunc "bin" "${files[@]}"
echo "-- Finished bin files"

# echo "-- Copying checklist-template"
# cp "$HOME/Personal/checklists/.template" checklist/.template
# echo "-- Finished Copying checklist-template"

echo "FINISHED COPY"
exit 0

