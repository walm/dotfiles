# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

Each top-level directory is a stow package that mirrors the `$HOME` tree:

| Package          | Contains                                         | Creates symlink at                                 |
| ---------------- | ------------------------------------------------ | -------------------------------------------------- |
| `zsh/`           | `.zshrc`                                         | `~/.zshrc`                                         |
| `git/`           | `.gitconfig`                                     | `~/.gitconfig`                                     |
| `starship/`      | `.config/starship.toml`                          | `~/.config/starship.toml`                          |
| `tmux/`          | `.config/tmux/tmux.conf`                         | `~/.config/tmux/tmux.conf`                         |
| `television/`    | `.config/television/..`                          | `~/.config/television/..`                          |
| `lf/`            | `.config/lf/lfrc`                                | `~/.config/lf/lfrc`                                |
| `shellfish_pkg/` | `.shellfish`                                     | `~/.shellfish`                                     |
| `scripts_pkg/`   | `bin/view`, `bin/font-test.sh`                   | `~/bin/view`, `~/bin/font-test.sh`                 |
| `lazygit_pkg/`   | `Library/Application Support/lazygit/config.yml` | `~/Library/Application Support/lazygit/config.yml` |
| `rubocop/`       | `.rubocop.yml`                                   | _(opt-in, commented out)_                          |

## Install

Prerequisites: [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)

```bash
git clone <repo-url> ~/src/dotfiles
cd ~/src/dotfiles
./install.sh
```

This will:

- Install [antigen](https://github.com/zsh-users/antigen) (zsh plugin manager) if not present
- Install [tpm](https://github.com/tmux-plugins/tpm) (tmux plugin manager) if not present
- Stow all packages, creating symlinks in `$HOME`

## Usage

```bash
# Install everything:
./install.sh

# Stow a single package manually:
stow -v --target="$HOME" tmux

# Unstow (remove symlinks for a package):
stow -v --target="$HOME" -D tmux

# Restow (useful after moving files around):
stow -v --target="$HOME" --restow tmux
```
