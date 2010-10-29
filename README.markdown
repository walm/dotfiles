# Walm's dotfiles

## Install:

Oneliner

  curl -L "http://github.com/walm/dotfiles/raw/master/install.sh" | bash

or

  git clone git://github.com/walm/dotfiles ~/.dotfiles
  cd ~/.dotfiles
  git submodule init
  git submodule update
  rake install
    
This rake task will not replace existing files, but it will replace existing symlinks.
The dotfiles will be symlinked, e.g. `~/.bash_profile` symlinked to `~/.dotfiles/bash_profile`.

## Environment

I'm running Mac OS X and primarily use zsh, but this includes some bash files as well. 
Switch to zsh with

  chsh -s /bin/zsh

## <.replace>

If e.g. `~/.dotfiles/gitconfig` contains `<.replace github-token>` then 

 * that bit will be replaced with the contents of `~/.github-token` 
 * the resulting file will be written to `~/.gitconfig` directly, not symlinked.
 
So if you want to make changes to that file, make them in `~/dotfiles/gitconfig` and then run `redot` (same as `rake install`).
Changes to symlinked files without `<.replace>` bits do not require a `redot` on every change as they're symlinked.

### Inspired by

[ryanb/dotfiles](http://github.com/ryanb/dotfiles/)

[henrik/dotfiles](http://github.com/henrik/dotfiles/)
