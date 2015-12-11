#!/bin/bash

# clone it if not exists
[[ -d ~/.dotfiles ]] || git clone git://github.com/walm/dotfiles.git ~/.dotfiles

# symbol link configs
ln -is ~/.dotfiles/bashrc ~/.bashrc
ln -is ~/.dotfiles/bash_profile ~/.bash_profile

ln -isf ~/.dotfiles/vim ~/.vim
ln -is ~/.dotfiles/vimrc ~/.vimrc

ln -is ~/.dotfiles/tmux.conf ~/.tmux.conf

ln -is ~/.dotfiles/gitconfig ~/.gitconfig
ln -is ~/.dotfiles/gitignore ~/.gitignore
ln -isf ~/.dotfiles/git_template ~/.git_template

ln -is ~/.dotfiles/inputrc ~/.inputrc
ln -is ~/.dotfiles/ctags ~/.ctags

# vim backup to ~/tmp so make sure it exists
mkdir -p ~/tmp

# osx specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -is ~/.dotfiles/tmux-osx.conf ~/.tmux-osx.conf
fi
