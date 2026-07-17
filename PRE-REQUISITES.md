# Pre-requisites

Tools that need to be installed (via `brew`) before running `./install.sh`.

## Required

These will break the setup if missing:

| Tool | Brew formula | Purpose |
|------|-------------|---------|
| stow | `brew install stow` | Dotfile symlink manager — install.sh exits without it |
| starship | `brew install starship` | Shell prompt |
| television | `brew install television` | Fuzzy finder (Ctrl-R / Ctrl-T) |
| atuin | `brew install atuin` | Shell history search |
| hunk | `brew install modem-dev/tap/hunk` | Terminal diff viewer |
| neovim | `brew install neovim` | Default editor (`EDITOR=nvim`) |
| bat | `brew install bat` | File previewer (used by `~/bin/view`) |
| mise | `brew install mise` | Runtime manager |
| bun | `brew install oven-sh/bun/bun` | JS runtime + package manager |
| but | `bun add -g but` | Bun task runner (completions loaded in .zshrc) |

## Optional / Nice-to-have

These are used conditionally or provide enhanced features:

| Tool | Brew formula | Purpose |
|------|-------------|---------|
| zoxide | `brew install zoxide` | Smarter `cd` — falls back to `z` if absent |
| exa | `brew install exa` | Modern `ls` replacement (`alias ls='exa --git'`) |
| lazygit | `brew install lazygit` | TUI git client — only stowed if present |
| rga | `brew install rga` | Ripgrep All (`alias ag=rga`) |
| timetrack | `brew install timetrack` | Time tracking (`alias tt=timetrack`, starship module) |
| ngrok | `brew install ngrok` | Completions loaded if present |
| worktrunk | `brew install worktrunk` | Git worktree utility — shell init if present |
| imagemagick | `brew install imagemagick` | Used by `thumbnail` in .shellfish |
| exiftool | `brew install exiftool` | Used by `thumbnail` in .shellfish |

## Quick install

```bash
brew install stow starship television atuin modem-dev/tap/hunk neovim bat bun rga exa lazygit timetrack mise
bun add -g but
```
