# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins to be loaded (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(debian colorize cp git history ng pylint python sudo tmux wd)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
fi

#########################
# Variables and aliases #
#########################

# Editor
alias te='emacs -nw'
alias xe='emacs &;disown'

# Terminal
export ZSH_FILE=$HOME/.zshrc
alias tv='colorize'
alias ez='emacs -nw ${ZSH_FILE}'
alias vz='colorize ${ZSH_FILE}'
alias sz='source ${ZSH_FILE}'
alias clc='clear'

