function gwcon --description "Create worktree for new branch and cd to it"
  set -l name $argv[1]
  if test -z "$name"
    echo "usage: gwcon <branch>"
    return 1
  end

  set -l root (git rev-parse --show-toplevel 2>/dev/null)
  or return 1

  set -l repo (basename $root)
  set -l parent (dirname $root)

  set -l base "$parent/.worktrees/$repo"
  set -l dir "$base/$name"

  mkdir -p "$base"

  git worktree add -b "$name" "$dir"
  or return 1

  cd "$dir"
end

