#
# ~/.bash_profile
#
# login-specific initializations

# ssh-agent should run
if ! pgrep -u $USER ssh-agent > /dev/null; then
  ssh-agent > ~/.ssh-agent-thing
fi
eval $(<~/.ssh-agent-thing)

# no keys in ssh-agent, first time ssh will add it
ssh-add -l > /dev/null || alias ssh='ssh-add -l > /dev/null || ssh-add && unalias ssh; ssh'

echo "Display is $DISPLAY"

# get the rest from interactive conf
[[ -f ~/.bashrc ]] && . ~/.bashrc
