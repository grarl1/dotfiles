#!/usr/bin/zsh

# Prompt
function prompt_bold_color() {
    echo "$fg_bold[$1]${@:2}$reset_color"
}
PROMPT=`prompt_bold_color green '%n'` # username
PROMPT+='@'
PROMPT+=`prompt_bold_color blue '%M: '` # hostname
PROMPT+=`prompt_bold_color magenta '${PWD/#$HOME/~}'` # working directory
PROMPT+=' $(git_prompt_info)' # git info
PROMPT+=`prompt_bold_color cyan '%W'` # Date
PROMPT+=' '
PROMPT+=`prompt_bold_color yellow '%*'` # Time
PROMPT+=`prompt_bold_color red '%(?.. rv: %?)'` # Return value
PROMPT+=`printf '\n>> '`
export PROMPT

# Key bindings
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Add home bin to path
export PATH=$HOME/bin:$PATH
