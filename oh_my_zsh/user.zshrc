#!/usr/bin/zsh

# Prompt
function prompt_color() {
    echo "$fg[$1]$2$reset_color"
}
PROMPT=`prompt_color green '%n'` # username
PROMPT+='@'
PROMPT+=`prompt_color blue '%M: '` # hostname
PROMPT+=`prompt_color magenta '${PWD/#$HOME/~}'` # working directory
PROMPT+=' $(git_prompt_info)' # git info
PROMPT+=`prompt_color cyan '%W'` # Date
PROMPT+=' '
PROMPT+=`prompt_color yellow '%*'` # Time
PROMPT+=`prompt_color red '%(?.. rv: %?)'` # Return value
PROMPT+=`printf '\n>> '`
export PROMPT
unset -f prompt_color

# Key bindings
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Add home bin to path
export PATH=${HOME}/bin:${PATH}

# Have a colorful life
export TERM=xterm-256color

# Useful aliases
alias diskspace="du -h | sort -h -r | less"

