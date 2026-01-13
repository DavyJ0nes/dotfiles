function gwco --description "cd to directory for the branch name (worktree)"
  set -l name $argv[1]
  if test -z "$name"
    echo "usage: gwco <branch>"
    return 1
  end

  set -l path ""
  set -l cur_path ""

  for line in (git worktree list --porcelain)
    if string match -rq '^worktree ' -- $line
      set cur_path (string replace -r '^worktree\s+' '' -- $line)
    else if string match -rq '^branch ' -- $line
      set -l b (string replace -r '^branch\s+refs/heads/' '' -- $line)
      if test "$b" = "$name"
        set path "$cur_path"
        break
      end
    end
  end

  if test -z "$path"
    echo "No worktree found for branch: $name"
    return 1
  end

  cd "$path"
end

