# Path to your oh-my-zsh installation.
export ZSH=/Users/davyjones/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gianu"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# PATH export
export PATH="/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/usr/local/games:/usr/games"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Custom env exports
export EDITOR='vim'

# Other scripts to source
source $ZSH/oh-my-zsh.sh
source ~/.tmux/tmuxinator.zsh
source /Users/davyjones/.rvm/scripts/rvm

# Custom aliases
alias pse='ps -eo pid,ppid,pcpu,args'
alias gpom="git push origin $(gb | grep  '*' | awk '{print $2}')"
alias sagi="sudo apt-get install"
alias gst="git status"
alias gl="git log"
alias pingg="ping 8.8.8.8"
alias rgrep="grep -r"

