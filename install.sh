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
PACKAGES=(zsh git starship tmux lf shellfish_pkg scripts_pkg)

# lazygit - only if installed
if command -v lazygit &>/dev/null; then
  PACKAGES+=(lazygit_pkg)
fi

# Uncomment to include rubocop config:
# PACKAGES+=(rubocop)

echo "Stowing packages: ${PACKAGES[*]}"
cd "$SCRIPT_DIR"
for pkg in "${PACKAGES[@]}"; do
  echo "  Stowing $pkg ..."
  stow -v --target="$HOME" --restow "$pkg"
done

echo "Done!"
