HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob

# -- path updates
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/davyjones/Library/Application\ Support/JetBrains/Toolbox/scripts:/usr/local/bin:$PATH
export GOPATH=$(go env GOPATH)
export EDITOR='vim'
export GPG_TTY=$(tty)


# -- oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export HOMEBREW_HOME="/opt/homebrew/Caskroom"
ZSH_THEME="refined"
plugins=(brew docker fzf git gh golang macos rust terraform)
source $ZSH/oh-my-zsh.sh

# -- rust
source "$HOME/.cargo/env"

# -- gcloud
source "$HOMEBREW_HOME/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$HOMEBREW_HOME/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
export CLOUDSDK_PYTHON_SITEPACKAGES=1.

# -- go
export GOROOT="/opt/homebrew/Cellar/go/$(ls -t /opt/homebrew/Cellar/go | head -1 | tr -d "/")/libexec"
export GOPRIVATE="github.com/einride,go.einride.tech"

# -- autocomplete
zstyle :compinstall filename '/Users/davyjones/.zshrc'
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

source <(sagaiamctl completion zsh)
source <(bookctl completion zsh)
source <(ownctl completion zsh)
source <(vehicleperformancectl completion zsh)

# -- fzf
source /opt/homebrew/Cellar/fzf/0.44.1/shell/key-bindings.zsh
source /opt/homebrew/Cellar/fzf/0.44.1/shell/completion.zsh
export FZF_DEFAULT_COMMAND="fd -L -H . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -L -H -t d . $HOME"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
bindkey '^F' fzf-cd-widget

# node
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# -- aliases
alias watch="watch "
alias walk="walk --icons"
alias vi="nvim"
alias vim="nvim"
alias editnvim="cd ~/.config/nvim/ && vi"
alias grep="rg"
alias cp="cp -iv"
alias mv="mv -iv"
alias ls="ls -FGh"
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

## -- git
alias gco="git checkout"
alias gitdock="docker run -v "$PWD":/srv/app davyj0nes/git"
alias gst="git status"
alias gs="git status"
alias gl="git log"
alias gaf='git add -A; git commit -m "WIP: $(w3m whatthecommit.com | head -n 1)"'
alias git-branch-name="git rev-parse --abbrev-ref HEAD"
alias ghstatus="curl -s https://www.githubstatus.com/api/v2/status.json | jq '{url: .page.url, status: .status.description}'"
alias ghstatus-f="while true; do ghstatus && sleep 30 && printf \"\033c\"; done"
alias ghprstatus="gh pr view --json \"statusCheckRollup\" | jq '.statusCheckRollup[] | {\"name\": .name, \"status\": .status}'"
alias ghprstatus-f="while true; do ghprstatus && sleep 30 && printf \"\033c\"; done"
alias gfuck="git commit --all --amend --no-edit"
alias gfuckoff="gfuck && git fetch && git rebase origin/master && git push -f"

# -- docker
# -- For Podman
export DOCKER_HOST="unix://${HOME}/.local/share/containers/podman/machine/qemu/podman.sock"
# export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
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

# -- golang
alias godavy="cd $GOPATH/src/github.com/davyj0nes"
alias gozettle="cd $GOPATH/src/github.com/iZettle"
alias goresetdeps="rm Gopkg.lock && rm vendor/ && dep ensure"
export GOPRIVATE=github.com/einride/*

# -- einride
alias setup-sage="go run go.einride.tech/sage@latest init"

# -- k8s
alias kb="kubectl"
alias k="kubectl"
alias mk="minikube"

# -- terraform
alias tf="terraform"

## -- dirs
alias goein="cd ~/go/src/github.com/einride"
alias godavy="cd ~/go/src/github.com/davyj0nes"

#### custom functions ####
function da() {
  docker start $1 && docker attach $1
}

function dockerstart() {
  docker-machine stop
  docker-machine start
  eval $(docker-machine env)
}

function dclean() {
  docker container prune -f
  docker image prune -f
  docker volume prune -f
}

function rant() {
  echo $1 > /dev/null
  echo "Rant over, go for a walk!"
}

function note() {
  echo "$1 \n" >> ~/.notes
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
