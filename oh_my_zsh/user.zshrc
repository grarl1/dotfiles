#!/usr/bin/zsh

# Prompt
export PROMPT='%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[blue]%}%M:%{$reset_color%}%{$fg_bold[magenta]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %{$fg_bold[cyan]%}%W%{$reset_color%} %{$fg_bold[yellow]%}%*%{$reset_color%} %(?..%{$fg_bold[red]%}rv: %?%{$reset_color%})
%B>>%b '

# Key bindings
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Add bin
export PATH=$HOME/bin:$PATH
