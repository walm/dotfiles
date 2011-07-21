if [ -f ~/.bashrc ];
then
  . ~/.bashrc
fi
if [[ -s ~/.rvm/scripts/rvm ]] ; then . ~/.rvm/scripts/rvm ; fi
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi
