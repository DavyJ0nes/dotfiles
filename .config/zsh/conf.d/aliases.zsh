# ── Grep ──────────────────────────────────────────────────────────────────────
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ── Navigation ────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ── File operations ───────────────────────────────────────────────────────────
alias cp='cp -Ri'
alias mv='mv -i'
alias md='mkdir -p'
alias rd='rmdir -p'

# ── Tools ─────────────────────────────────────────────────────────────────────
alias watch='watch '
alias walk='walk --icons'
alias vim='nvim'
alias vi='nvim'
alias du='du -cksh'
alias df='df -h'
alias sed='gsed'
alias realpath='grealpath'
alias rgrep='grep -r'
alias pse='ps -eo pid,ppid,pcpu,args'
alias pingg='ping 8.8.8.8'
alias here='pwd | pbcopy'
alias grepip="grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
alias idea='goland'
alias make='gmake'
alias mux='tmuxinator'
alias docker='podman'
alias cat='bat'
alias suggest='gh copilot suggest -t shell'

# Search shortcuts (noglob prevents ? from expanding as a glob)
alias '?'='noglob __ddg'
alias '??'='noglob __claude_search'

# ── Eza (ls replacement) ──────────────────────────────────────────────────────
alias ls='eza --group --group-directories-first'
alias l='eza --group --group-directories-first --long --all --binary'
alias la='eza --group --group-directories-first --all --binary'
alias li='eza --group --group-directories-first --icons'
alias ld='eza --group --group-directories-first --only-dirs'
alias lo='eza --group --group-directories-first --oneline'
alias lc='eza --group --group-directories-first --across'
alias lt='eza --group --group-directories-first --tree'
alias lg='eza --group --group-directories-first --long --git --git-ignore'

# ── Notes & Tasks ─────────────────────────────────────────────────────────────
alias inbox='nothelp today'
alias start='nothelp start'
alias stop='nothelp stop'
alias log='nothelp log'
alias today='nothelp today'
alias yesterday='nothelp yesterday'
alias tsync='task-sync'
alias notes="cd $HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/notes/"

# ── Taskwarrior ───────────────────────────────────────────────────────────────
alias t='task'
alias ta='task add'
alias td='task delete'
alias tm='task modify'
alias done='task done'
alias tasks='taskwarrior-tui'
alias tall='task context none; task'
alias topen='taskopen'
alias tinbox='task context none; task inbox'
alias startinbox='task context none; taskwarrior-tui -r inbox'
alias tai='task context none; task add +inbox'
alias tpersonal='task context personal; task'
alias tap='task context personal; task add +personal'
alias ttoday='task context none; task today'
alias twork='task context work; task'
alias taw='task context work; task add +work'
alias tlearn='task context learning; task'
alias tal='task context learning; task add +learning'
alias tal-elixir='task context learning; task add +learning project:elixir'
alias tdnd='task context dnd; task'
alias tadnd='task context dnd; task add +dnd +personal'
alias ttrain='task context training; task'

# ── Clojure ───────────────────────────────────────────────────────────────────
alias crepl='clojure -M:repl/basic'
alias crepl-headless='clojure -M:repl/headless'

# ── Elixir ────────────────────────────────────────────────────────────────────
alias miex='iex -S mix'

# ── Git ───────────────────────────────────────────────────────────────────────
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit --verbose'
alias gst='git status'
alias gl='git log'
alias gdiff='git diff'
alias gw='git worktree list'
alias git-branch-name='git rev-parse --abbrev-ref HEAD'
alias gfuck='git add . && git commit --amend --no-edit'
alias gfuckoff='gfuck && git fetch && git rebase origin/main && git push -f'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify --message "--wip-- [skip ci]"'
alias gaf='git add -A; git commit -m "WIP: $(w3m whatthecommit.com | head -n 1)"'
alias gitdock='docker run -v "$PWD":/srv/app davyj0nes/git'
alias ghstatus="curl -s https://www.githubstatus.com/api/v2/status.json | jq '{url: .page.url, status: .status.description}'"
alias ghprstatus='gh pr view --json "statusCheckRollup" | jq '"'"'.statusCheckRollup[] | {"name": .name, "status": .status}'"'"''

# ── Docker ────────────────────────────────────────────────────────────────────
alias dm='docker-machine'
alias dps='docker ps'
alias drm='docker rm'
alias dkill='docker kill'
alias dco='docker-compose'
alias dockernotary='notary -s https://notary.docker.io -d ~/.docker/trust'
alias pgport="jq '.[0].NetworkSettings.Ports.\"5432/tcp\"[0].HostPort' | tr -d '\"'"
alias ctop='docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

# ── Kubernetes ────────────────────────────────────────────────────────────────
alias k='kubectl'
alias kb='kubectl'
alias mk='minikube'
alias kctx='kubectl config get-contexts'
alias kcc='kubectl config use-context'
alias kcur='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kubectl get pods --watch'
alias kgpwide='kubectl get pods -o wide'
alias kdp='kubectl describe pod'
alias kgd='kubectl get deployments'
alias kdd='kubectl describe deployment'
alias krd='kubectl rollout restart deployment'
alias kgs='kubectl get services'
alias kds='kubectl describe service'
alias kgn='kubectl get nodes'
alias kdn='kubectl describe node'
alias kgns='kubectl get namespaces'
alias kl='kubectl logs'
alias klf='kubectl logs --follow'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kex='kubectl exec -it'

# ── Terraform ─────────────────────────────────────────────────────────────────
alias tf='terraform'

# ── Directory shortcuts ───────────────────────────────────────────────────────
alias goein="cd $GOPATH/src/github.com/einride"
alias godavy="cd $GOPATH/src/github.com/davyj0nes"
alias gofever="cd $GOPATH/src/github.com/feverenergy"
alias goconfig="cd $HOME/dotfiles/"
alias gonotes="cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes"
alias gozk="cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes/zk"

# ── Headphones ────────────────────────────────────────────────────────────────
alias commbadge='blueutil --connect 68-ca-c4-cc-11-ee'
alias cb='commbadge'
alias whsony='blueutil --connect 94-db-56-5f-d2-fe'
alias wh='whsony'
