########## ZSHRC ##########
######## DavyJ0nes ########


#### ZSH Config ####
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="miloshadzic"
plugins=(git zsh-syntax-highlighting docker)


#### PATH export ####

export GOPATH=/home/umo/CODE/go
export PATH="/sbin:/usr/local/bin:/usr/sbin:/bin:/usr/bin:/usr/local/games:/usr/games:/usr/local/go/bin:$HOME/CODE/bin:$GOPATH/bin"
export PATH="/opt/chefdk/bin:$PATH"
export TERM="xterm-256color"

# Ruby version with rbenv
# eval "$(rbenv init -)"

#### Custom env exports ####
export EDITOR='vim'


#### Other scripts to source ####
source $ZSH/oh-my-zsh.sh
# source ~/.tmux/tmuxinator.zsh
# GCLOUD related stuff
# source '/Users/davidjones/google-cloud-sdk/path.zsh.inc'
# source '/Users/davidjones/google-cloud-sdk/completion.zsh.inc'
# Kubectl completion
# source <(kubectl completion zsh)
# AWS CLI completion
source /usr/local/bin/aws_zsh_completer.sh

# Custom CD path
# setopt auto_cd
# cdpath=($HOME/Forge/CODE/Repos/* $HOME/Forge/CODE/* $HOME/Personal)

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
# linux related
alias pbcopy="xclip -sel clip"
alias open="xdg-open"
# vim links
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
alias python="python3"
alias pip="pip3"
# Kubenetes
# alias kb="kubectl"
# Helpers
alias getip="wget http://ipinfo.io/ip -qO -"

#### Custom Functions ####
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
