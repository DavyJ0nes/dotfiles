# Path to your oh-my-zsh installation.
export ZSH=/Users/davidjones/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

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
alias vim='/usr/local/Cellar/vim/7.4.2210/bin/vim'
alias vi='/usr/local/Cellar/vim/7.4.2210/bin/vim'
alias pse='ps -eo pid,ppid,pcpu,args'
#alias gpom="git push origin $(gb | grep  '*' | awk '{print $2}')"
alias gst="git status"
alias gl="git log"
alias pingg="ping 8.8.8.8"
alias rgrep="grep -r"
alias a="ansible"
alias play="ansible-playbook"
alias cc="codeclimate"
alias dm="docker-machine"
eval `docker-machine env 2>/dev/null`

function dockerstart() {
  docker-machine stop vmf
  docker-machine start vmf
  eval $(docker-machine env vmf)
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

function s-tmp() {
  ssh 10.10.10.1 'ls -alh /tmp/bluemark/*'
}

function ex-flush() {
  curl -v -X POST https://exposuredb.com/events/events/$1/flush_cache | grep HTTP
  echo " ***** flushed cache for event $1 *****"
}

function bm-login() {
  ssh bm-collector "sudo netstat -4plunt | grep blue"
}

function ssh-sensor() {
  ssh -A -t bm-collector ssh -A -t -p $1 root@localhost "$2"
}

function ssh-list() {
  ssh bm-collector 'hostname; sudo netstat -4plunt | grep blue'
}

function rant() {
  echo $1 > /dev/null
  echo "Rant over, go for a walk!"
}

function note() {
  echo "$1 \n" >> ~/.notes
}

function status() {
  cd /Users/davidjones/Forge/CODE/Repos/forge-tools/sensor_status
  ruby sensor_status.rb -d 30 $1
  cd -
}

function ex-ip() {
  ruby ~/Forge/CODE/Repos/forge-tools/vike/lib/aws-sg-updater/sg_updater.rb
}

function ex-run() {
  ~/Forge/CODE/Repos/PROD/exposure_web/docker-tasks/bin/bundle exec rails s -b 0.0.0.0 -p 3000:3000 -e RAILS_ENV=development -e EX_ASSET_NO_DEBUG=1
}
