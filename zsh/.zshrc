# reload with `omz reload`
source $HOME/antigen.zsh

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

antigen use oh-my-zsh

# bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle hkupty/ssh-agent
antigen bundle common-aliases
# antigen bundle atuinsh/atuin@main

if type zoxide &>/dev/null
then
  eval "$(zoxide init zsh)"
else
  ZSHZ_KEEP_DIRS=/mnt/hal13
  antigen bundle z
fi

antigen bundle vi-mode
antigen apply

VI_MODE_SET_CURSOR=true

# prepend to path
path=("$HOME/.local/bin" $path)
path=("$HOME/bin" $path)
if type brew &>/dev/null
then
  path=("$(brew --prefix)/opt/curl/bin" $path)
fi

# bun global installs
path=("/Users/walm/.bun/bin" $path)

# added by Antigravity
# path=("/Users/walm/.antigravity/antigravity/bin" $path)

export PATH

# completion
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

eval "$(mise activate zsh)"

export EDITOR=nvim

# alias
type exa &>/dev/null && alias ls='exa --git'
alias j=z
alias g=git
alias lg=lazygit
alias d=docker
alias vim=nvim
alias e=nvim
alias v=view
alias more=view
alias ag=rga
alias tt=timetrack
alias cld=claude
alias cldt=claude-trace
alias tailscale=/Applications/Tailscale.app/Contents/MacOS/tailscale

# copilot for cli
alias \?\?="gh copilot suggest -t shell"
# alias: ghcs ghce
# https://docs.github.com/en/copilot/managing-copilot/configure-personal-settings/configuring-github-copilot-in-the-cli#setting-up-aliases
# eval "$(gh copilot alias -- zsh)"

alias :q=exit

# iPad shellfish integration
source $HOME/.shellfish

# atuin init
# - history tracker
# if command -v atuin &>/dev/null; then
#   source "$HOME/.atuin/bin/env"
#   eval "$(atuin init --disable-up-arrow zsh)"
# fi

# worktrunk init
# - git worktree util
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# television for history (Ctrl-R) smart autocomplete (Ctrl-T)
eval "$(tv init zsh)"

# starship prompt init
eval "$(starship init zsh)"

# clean up and fixes
unalias br 2>/dev/null  # remove conflicting alias
unalias bb 2>/dev/null  # remove conflicting alias

