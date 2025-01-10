# enable profiling
# zmodload zsh/zprof

# basic set up
export CC=/opt/homebrew/Cellar/gcc/14.2.0_1/bin/gcc-14
export GPG_TTY=$(tty)
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export EDITOR='nvim'
export TERM=alacritty
export HOMEBREW_HOME="/opt/homebrew/Caskroom"
setopt extendedglob

# generic Path Updates
eval "$(/opt/homebrew/bin/brew shellenv)"
export GOBIN=$HOME/go/bin
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$PATH:$GOBIN
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/bin
export GOPATH=$(go env GOPATH)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Completion
zstyle :compinstall filename '/Users/davyjones/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit; compinit
_comp_options+=(globdots)

# Rust stuff
source "$HOME/.cargo/env"

# GCLOUD related stuff
source "$HOMEBREW_HOME/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$HOMEBREW_HOME/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Go stuff
export GOPRIVATE=github.com/einride/*

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
source /opt/homebrew/Cellar/fzf/0.57.0/shell/key-bindings.zsh
source /opt/homebrew/Cellar/fzf/0.57.0/shell/completion.zsh
export FZF_DEFAULT_COMMAND="fd -L -H . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -L -H -t d . $HOME"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
bindkey '^F' fzf-cd-widget
eval "$(fzf --zsh)"


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"


# -- aliases ---
alias ..="cd .."
alias watch="watch "
alias walk="walk --icons"
alias vim="nvim"
alias vi="vim"
alias v="vim"
alias editnvim="cd ~/.config/nvim/ && vi"
alias cp="cp -iv"
alias mv="mv -iv"
alias ls="eza"
alias l="ls -al"
alias du="du -cksh"
alias df="df -h"
alias sed="gsed"
alias realpath="grealpath"
alias rgrep="grep -r"
alias pse='ps -eo pid,ppid,pcpu,args'
alias pingg="ping 8.8.8.8"
alias here="pwd | pbcopy"
alias grepip="grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
alias python="python3"
alias idea="goland"
alias make="gmake"
alias mux="tmuxinator"
alias docker="podman"
alias inbox="nvim ~/notes/inbox.norg"

# -- clojure
alias crepl="clojure -M:repl/basic"
alias crepl-headless="clojure -M:repl/headless"

## Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gco="git checkout"
alias gc='git commit --verbose'
alias gitdock="docker run -v "$PWD":/srv/app davyj0nes/git"
alias gst="git status"
alias gl="git log"
alias gaf='git add -A; git commit -m "WIP: $(w3m whatthecommit.com | head -n 1)"'
alias git-branch-name="git rev-parse --abbrev-ref HEAD"
alias ghstatus="curl -s https://www.githubstatus.com/api/v2/status.json | jq '{url: .page.url, status: .status.description}'"
alias ghstatus-f="while true; do ghstatus && sleep 30 && printf \"\033c\"; done"
alias ghprstatus="gh pr view --json \"statusCheckRollup\" | jq '.statusCheckRollup[] | {\"name\": .name, \"status\": .status}'"
alias ghprstatus-f="while true; do ghprstatus && sleep 30 && printf \"\033c\"; done"
alias gfuck="git add . && git commit --amend --no-edit"
alias gfuckoff="gfuck && git fetch && git rebase origin/master && git push -f"
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

# Docker
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"
export TESTCONTAINERS_RYUK_DISABLED=true
alias dm="docker-machine"
alias dps="docker ps"
alias drm="docker rm"
alias dkill="docker kill"
alias dco="docker-compose"
alias dockernotary="notary -s https://notary.docker.io -d ~/.docker/trust"
alias pgport="jq '.[0].NetworkSettings.Ports.\"5432/tcp\"[0].HostPort' | tr -d '\"'"
alias ctop="docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"

# Kubenetes
alias kb="kubectl"
alias k="kubectl"
alias mk="minikube"

# Terraform
alias tf="terraform"

## -- dirs
alias goein="cd $GOPATH/src/github.com/einride"
alias godavy="cd $GOPATH/src/github.com/davyj0nes"
alias gorustlings="cd $HOME/rust/rustlings"
alias gonote="cd /Users/davyjones/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/umo"
alias goconfig="cd $HOME/.config/nvim/lua"
alias notes "cd $HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/version2"

## -- connect headphones
alias commbadge="blueutil --connect 68-ca-c4-cc-11-ee"
alias cb="commbadge"
alias whsony="blueutil --connect 94-db-56-5f-d2-fe"
alias wh="whsony"

#### custom functions ####
function dclean() {
  docker container prune -f
  docker image prune -f
  docker volume prune -f
}

function iperfsummary() {
  if [ "$1" = "" ]; then
    echo "server address not set"
    return 1
  fi
  iperf3 -c "$1" -J | jq '.end | {received: .sum_received.bits_per_second, sent: .sum_sent.bits_per_second}'
}

function isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

function man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

function calc() {
	# local result=""
	result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"
	#						└─ default (when `--mathlib` is used) is 20

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		# add "0" for cases like ".5"
		# add "0" for cases like "-.5"
		# remove trailing zeros
		printf "%s" "$result" |
			sed -e 's/^\./0./'  \
			-e 's/^-\./-0./' \
			-e 's/0*$//;s/\.$//'
	else
		printf "%s" "$result"
	fi
	printf "\\n"
}

function kbgetall() {
  if [ "$1" != "" ]; then
    NS="-n $1"
  else
    NS="--all-namespaces"
  fi

  echo "PODS" && echo "----"
  kubectl get pods "$NS"
  echo "\nSERVICES" && echo "--------"
  kubectl get svc "$NS"
  echo "\nDEPLOYMENTS" && echo "---------"
  kubectl get deployments "$NS"
  echo "\nINGRESS" && echo "-------"
  kubectl get ingress "$NS"
  echo "\nJOBS" && echo "-------"
  kubectl get jobs "$NS"
}

function gpob() {
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

function check-helm-values() {
  grep -A 5 "\- name: $1" dev.yml stg.yml minikube.yml prd.yml
}

function whoseport() {
  lsof -i ":$1" | grep LISTEN
}

function apidocs() {
  awk '/tests :=/,/^$/' $1 | tail -n +9 | tr -d '\t' | sed -E -e 's/^},|^{|^}//'
}

function gocheckshit() {
  echo -e "\e[33mrunning linter...\e[0m"
  golangci-lint run --no-config --deadline=30m -E gosec -E goimports -E goconst

  echo -e "\e[33mrunning tests...\e[0m"
  go test -race ./...
}

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function gi() {
  curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
