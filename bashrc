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

# easy color
source ~/.dotfiles/colors

source ~/.dotfiles/exports
source ~/.dotfiles/prompt
source ~/.dotfiles/aliases
source ~/.dotfiles/functions
source ~/.dotfiles/completion

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

