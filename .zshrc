# Path to your oh-my-zsh installation.
export ZSH=/home/umo/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gianu"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

source $ZSH/oh-my-zsh.sh

alias pse='ps -eo pid,ppid,pcpu,args'
alias gpom="git push origin master"
alias sagi="sudo apt-get install"
alias g st="git status"
alias gl="git log"
alias ping g="ping 8.8.8.8"
