. ~/.zsh/config
. ~/.zsh/completion
. ~/.zsh/aliases
if [[ -s ~/.rvm/scripts/rvm ]] ; then . ~/.rvm/scripts/rvm ; fi
if [[ -s ~/.tmuxinator/scripts/tmuxinator ]] ; then . ~/.tmuxinator/scripts/tmuxinator ; fi
if [ -f `brew --prefix`/etc/autojump ]; then . `brew --prefix`/etc/autojump ; fi
