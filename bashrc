# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# use vi bindings
set -o vi

# update the values of LINES and COLUMNS on resize
shopt -s checkwinsize

# auto correct typos when using `cd`
shopt -s cdspell

# append to ~/.bash_history
shopt -s histappend;

# keyboard bindings
bind -m vi-insert "\C-l":clear-screen

source ~/.dotfiles/exports
if [[ -f ~/.exports ]]; then source ~/.exports; fi

source ~/.dotfiles/prompt
source ~/.dotfiles/aliases
source ~/.dotfiles/completion
source ~/.dotfiles/paths

# colors
if type "dircolors" &> /dev/null; then
  test -e ~/.dir_colors && eval `dircolors -b ~/.dir_colors`
fi

# autojump
if [[ -f /etc/profile.d/autojump.sh ]]; then . /etc/profile.d/autojump.sh; fi

# ruby
if type "rbenv" &> /dev/null; then eval "$(rbenv init -)"; fi

# osx brew
if type "brew" &> /dev/null; then
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
fi

# source saved docker-machine-env
if [[ -f ~/.docker-machine-env ]]; then source ~/.docker-machine-env; fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
