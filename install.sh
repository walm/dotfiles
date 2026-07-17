#!/usr/bin/env bash
set -e

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -- zsh antigen plugin manager
if [[ ! -f ~/antigen.zsh ]]; then
  echo "Installing antigen.zsh ..."
  curl -L git.io/antigen >~/antigen.zsh
fi

# -- tmux tpm plugin manager
if [[ ! -e ~/.tmux/plugins/tpm ]]; then
  echo "Installing tmux tpm ..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# -- stow packages (symlinks configs to $HOME)
if ! command -v stow &>/dev/null; then
  echo "Error: GNU Stow is not installed. Install it first (e.g. brew install stow)"
  exit 1
fi

# Core packages - always installed
PACKAGES=(zsh git starship tmux lf television atuin hunk mpv shellfish_pkg scripts_pkg claude)

# herdr - only if installed
if command -v herdr &>/dev/null; then
  PACKAGES+=(herdr)
fi

# lazygit - only if installed
if command -v lazygit &>/dev/null; then
  PACKAGES+=(lazygit_pkg)
fi

# install tridactyl if zen browser 
if [ -d "/Applications/Zen.app" ]; then
  PACKAGES+=(tridactyl)
fi

# Uncomment to include rubocop config:
# PACKAGES+=(rubocop)

echo "Stowing packages: ${PACKAGES[*]}"
cd "$SCRIPT_DIR"
for pkg in "${PACKAGES[@]}"; do
  if [[ "$pkg" == "herdr" && -e "$HOME/.config/herdr/config.toml" && ! -L "$HOME/.config/herdr/config.toml" ]]; then
    backup="$HOME/.config/herdr/config.toml.backup.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up existing Herdr config to $backup ..."
    mv "$HOME/.config/herdr/config.toml" "$backup"
  fi

  if [[ "$pkg" == "atuin" && -e "$HOME/.config/atuin/config.toml" && ! -L "$HOME/.config/atuin/config.toml" ]]; then
    backup="$HOME/.config/atuin/config.toml.backup.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up existing Atuin config to $backup ..."
    mv "$HOME/.config/atuin/config.toml" "$backup"
  fi

  if [[ "$pkg" == "hunk" && -e "$HOME/.config/hunk/config.toml" && ! -L "$HOME/.config/hunk/config.toml" ]]; then
    backup="$HOME/.config/hunk/config.toml.backup.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up existing Hunk config to $backup ..."
    mv "$HOME/.config/hunk/config.toml" "$backup"
  fi

  echo "  Stowing $pkg ..."
  stow -v --target="$HOME" --restow "$pkg"
done

echo "Done!"
