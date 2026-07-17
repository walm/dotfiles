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
path=("$HOME/.atuin/bin" $path)
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
_zsh_completion_cache_dir="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/completions"
_cache_zsh_completion() {
  local name="$1"
  shift
  local completion="$_zsh_completion_cache_dir/_$name"

  if command -v "$1" &>/dev/null && [[ ! -f "$completion" ]]; then
    mkdir -p "$completion:h"
    "$@" > "$completion.tmp" && mv "$completion.tmp" "$completion"
    rm -f "$completion.tmp"
  fi
}

_zsh_cached_completions=(ngrok pnpm mise but)
_cache_zsh_completion ngrok ngrok completion
_cache_zsh_completion pnpm pnpm completion zsh
_cache_zsh_completion mise mise completion zsh
_cache_zsh_completion but but completions zsh
fpath=("$_zsh_completion_cache_dir" $fpath)
autoload -Uz compinit
compinit -C

if (( $+functions[compdef] )); then
  for _zsh_completion in "${_zsh_cached_completions[@]}"; do
    if [[ -f "$_zsh_completion_cache_dir/_$_zsh_completion" ]]; then
      autoload -Uz "_$_zsh_completion"
      compdef "_$_zsh_completion" "$_zsh_completion"
    fi
  done
fi

unset -f _cache_zsh_completion
unset _zsh_completion_cache_dir _zsh_completion _zsh_cached_completions

eval "$(mise activate zsh)"

export EDITOR=nvim

# macOS skip ._* files in tar's
export COPYFILE_DISABLE=1

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
alias serve="python3 -m http.server 8000"

alias \?\?="apfel"

# copilot for cli
# alias \?\?="gh copilot --"
# alias: ghcs ghce
# https://docs.github.com/en/copilot/managing-copilot/configure-personal-settings/configuring-github-copilot-in-the-cli#setting-up-aliases
# eval "$(gh copilot alias -- zsh)"

alias :q=exit

# iPad shellfish integration
source $HOME/.shellfish

# Atuin history search (including directory-scoped Up-arrow history)
if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

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


# pnpm
export PNPM_HOME="/Users/walm/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

