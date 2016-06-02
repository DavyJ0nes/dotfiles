# Path to your oh-my-zsh installation.
export ZSH=/Users/davidjones/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="risto"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# PATH export
export PATH="/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/usr/local/games:/usr/games:/usr/local/go/bin"
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Custom env exports
export EDITOR='vim'
export GOPATH=/Users/davidjones/Forge/CODE/go


# Other scripts to source
source $ZSH/oh-my-zsh.sh
source ~/.tmux/tmuxinator.zsh

# Ruby version with rbenv
eval "$(rbenv init -)"

# Custom aliases
alias pse='ps -eo pid,ppid,pcpu,args'
#alias gpom="git push origin $(gb | grep  '*' | awk '{print $2}')"
alias gst="git status"
alias gl="git log"
alias pingg="ping 8.8.8.8"
alias rgrep="grep -r"
alias a="ansible"
alias play="ansible-playbook"
eval `docker-machine env 2>/dev/null`

function dockerstart() {
  docker-machine stop
  docker-machine start
  eval $(docker-machine env)
}
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
