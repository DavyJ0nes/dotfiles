########## ZSHRC ##########
######## DavyJ0nes ########


#### ZSH Config ####
export ZSH=/Users/davidjones/.oh-my-zsh
ZSH_THEME="miloshadzic"
plugins=(git zsh-syntax-highlighting jira docker)


#### PATH export ####

export GOPATH=/Users/davidjones/go
export PATH="/sbin:/usr/local/bin:/usr/sbin:/bin:/usr/bin:/usr/local/games:/usr/games:/usr/local/go/bin:$HOME/bin:$GOPATH/bin"
export PATH="/opt/chefdk/bin:$PATH"

# Ruby version with rbenv
eval "$(rbenv init -)"

#### Custom env exports ####
export EDITOR='vim'
export JIRA_URL='https://forgesp.atlassian.net'


#### Other scripts to source ####
source $ZSH/oh-my-zsh.sh
source ~/.tmux/tmuxinator.zsh
# source $GOPATH/src/Forge/sensorStatus/.env
# GCLOUD related stuff
source '/Users/davidjones/google-cloud-sdk/path.zsh.inc'
source '/Users/davidjones/google-cloud-sdk/completion.zsh.inc'
# Kubectl completion
source <(kubectl completion zsh)
# AWS CLI completion
source /usr/local/bin/aws_zsh_completer.sh

# Custom CD path
setopt auto_cd
cdpath=($HOME/Forge/CODE/Repos/* $HOME/Forge/CODE/* $HOME/Personal)

#### Aliases ####
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias ls="ls -FGh"
alias du="du -cksh"
alias df="df -h"
alias rgrep="grep -r"
alias pse='ps -eo pid,ppid,pcpu,args'
alias pingg="ping 8.8.8.8"
alias here="pwd | pbcopy"
alias grepip="grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
# vim links
# alias vim="/usr/local/Cellar/vim/7.4.2210/bin/vim"
# alias vi="/usr/local/Cellar/vim/7.4.2210/bin/vim"
alias vim=nvim
alias vi=nvim
# git
alias gpom="git push origin $(gb | grep '^*' | sed 's/* //')"
alias gst="git status"
alias gl="git log"
# Ansible
alias a="ansible -i hosts"
alias play="ansible-playbook"
# Docker
alias dm="docker-machine"
alias dps="docker ps"
alias drm="docker rm"
alias dkill="docker kill"
alias dco="docker-compose"
alias des="cd ~/Personal/CODE/docker-es/v5.2"
# Golang
alias mango="open http://localhost:6060 && godoc -http=:6060"
# Python
# alias python="python3"
# alias pip="pip3"
# Kubenetes
alias kb="kubectl"
# Helpers
alias getip="wget http://ipinfo.io/ip -qO -"
# IF FIRE DELETE THIS
# alias vi="code"
# alias vim="code"


#### Custom Functions ####
# Sensor Commands
function s-tug() {
  cd ~/Forge/CODE/Bash/bm-config-scripts/utility_scripts/onsite-tools
  ./sensor-tug.sh
}

function s-time() {
  ssh 10.10.10.1 'hwclock && date'
}

function s-mnt() {
  ssh 10.10.10.1 'ls -alh /mnt/*'
}

function s-tmp() {
  ssh 10.10.10.1 'ls -alh /tmp/bluemark/*'
}

function ssh-sensor() {
  ssh -A -t bm-collector ssh -A -t -p $1 root@localhost "$2"
}

function ssh-list() {
  ssh bm-collector "hostname; ss -nltup|grep 127.0.0.1:22"
}

function ex-flush() {
  curl -v -X POST https://exposuredb.com/events/events/$1/flush_cache | grep HTTP
  echo " ***** flushed cache for event $1 *****"
}

function 4g-ip() {
  ssh fspsupport@192.168.101.1 "cat /status/dhcpd/leases/*" | jq '.[] | {name: .hostname, mac: .mac, ip: .ip_address}'
}

# Docker related commands
function da() {
  docker start $1 && docker attach $1
}

function dockerstart() {
  docker-machine stop
  docker-machine start
  eval $(docker-machine env)
}

function dclean() {
  docker rm $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

function ex-run() {
  ~/Forge/CODE/Repos/PROD/exposure_web/docker-compose/bin/bundle exec rails s -b 0.0.0.0 -p 3000:3000 -e RAILS_ENV=development -e EX_ASSET_NO_DEBUG=1
}

# Misc commands that don't warrant being in ~/bin
function rant() {
  echo $1 > /dev/null
  echo "Rant over, go for a walk!"
}

function note() {
  echo "$1 \n" >> ~/.notes
}

func venvproject() {
  echo "going to $1"
  cd $1 && source .lpvenv/bin/activate
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

clear
