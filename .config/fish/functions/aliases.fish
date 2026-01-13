# Colorize grep output (good for log files)
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'

# Confirm before overwriting
alias cp 'cp -Ri'
alias mv 'mv -i'

alias md 'mkdir -p'
alias rd 'rmdir -p'

alias which "type"
alias watch "watch"
alias walk "walk --icons"
alias vim "nvim"
alias vi "vim"
alias ls "eza"
alias l "eza -al"
alias du "du -cksh"
alias df "df -h"
alias sed "gsed"
alias realpath "grealpath"
alias rgrep "grep -r"
alias pse 'ps -eo pid,ppid,pcpu,args'
alias pingg "ping 8.8.8.8"
alias here "pwd | pbcopy"
alias grepip "grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
# alias python "python3"
alias idea "goland"
alias make "gmake"
alias mux "tmuxinator"
alias docker "podman"
alias cat "bat"

# -- Notes ahd Tasks
alias inbox "nothelp today"
alias start "nothelp start"
alias stop "nothelp stop"
alias log "nothelp log"
alias today "nothelp today"
alias yesterday "nothelp yesterday"
alias tsync "task-sync"
alias notes "cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/notes/"

# -- Taskwarrior aliases
alias t "task"
alias ta "task add"
alias td "task delete"
alias tm "task modify"
alias done "task done"
alias tasks "taskwarrior-tui"
alias tall "task context none; task"
alias topen "taskopen"

alias tinbox "task context none; task inbox"
alias startinbox "task context none; taskwarrior-tui -r inbox"
alias tai 'task context none; task add +inbox'

alias tpersonal "task context personal; task"
alias tap 'task context personal; task add +personal'

alias ttoday "task context none; task today"

## Work related

alias twork "task context work; task"

# Default work task
alias taw 'task context work; task add +work'

## LEARNING / CAREER

alias tlearn "task context learning; task"
alias tal 'task context learning; task add +learning'

# General tech / long-term growth
alias tal-elixir 'task context learning; task add +learning project:elixir'

## TTRPG

alias tdnd "task context dnd; task"
alias tadnd 'task context dnd; task add +dnd +personal'

## TRAINING

alias ttrain "task context training; task"

# -- clojure
alias crepl "clojure -M:repl/basic"
alias crepl-headless "clojure -M:repl/headless"

# -- elixir
alias miex "iex -S mix"

# -- git
alias g 'git'
alias gdiff 'git diff'
alias ga 'git add'
alias gaa 'git add --all'
alias gb 'git branch'
alias gco "git checkout"
alias gc 'git commit --verbose'
alias gitdock "docker run -v "$PWD":/srv/app davyj0nes/git"
alias gst "git status"
alias gl "git log"
alias gaf 'git add -A; git commit -m "WIP: $(w3m whatthecommit.com | head -n 1)"'
alias git-branch-name "git rev-parse --abbrev-ref HEAD"
alias gfuck "git add . && git commit --amend --no-edit"
alias gfuckoff "gfuck && git fetch && git rebase origin/main && git push -f"
alias gwip 'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --message "--wip-- [skip ci]"'
alias ghstatus "curl -s https://www.githubstatus.com/api/v2/status.json | jq '{url: .page.url, status: .status.description}'"
alias ghprstatus "gh pr view --json \"statusCheckRollup\" | jq '.statusCheckRollup[] | {\"name\": .name, \"status\": .status}'"
# alias ghnewpr "git fetch && git rebase origin/main && gh pr create --title \"$(git log -1 --pretty=%s)\" --body \"_Why?_ $(git log -1 --pretty=%b | grep -v 'Co-authored-by' | awk 'BEGIN {RS=\"\n\n\"; FS=\"\n\"; OFS=\" \"} {for (i=1;i<=NF;i++) printf \"%s\", $i (i==NF ? \\'\n\n\\' : OFS)}')\""
alias suggest "gh copilot suggest -t shell"

# -- git worktrees
alias gw 'git worktree list'

# -- docker
alias dm "docker-machine"
alias dps "docker ps"
alias drm "docker rm"
alias dkill "docker kill"
alias dco "docker-compose"
alias dockernotary "notary -s https://notary.docker.io -d ~/.docker/trust"
alias pgport "jq '.[0].NetworkSettings.Ports.\"5432/tcp\"[0].HostPort' | tr -d '\"'"
alias ctop "docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"

# -- kubenetes
alias kb "kubectl"
alias k "kubectl"
alias mk "minikube"

# -- terraform
alias tf "terraform"

# -- dirs
alias goein "cd $GOPATH/src/github.com/einride"
alias godavy "cd $GOPATH/src/github.com/davyj0nes"
alias gofever "cd $GOPATH/src/github.com/feverenergy"
alias gonotes "cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes"
alias gozk "cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes/zk"

# -- connect headphones
alias commbadge "blueutil --connect 68-ca-c4-cc-11-ee"
alias cb "commbadge"
alias whsony "blueutil --connect 94-db-56-5f-d2-fe"
alias wh "whsony"
