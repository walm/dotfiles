#!/bin/bash

# clone it if not exists
[[ -d ~/.dotfiles ]] || git clone git://github.com/walm/dotfiles.git ~/.dotfiles

# symbol link configs
ln -is ~/.dotfiles/bashrc ~/.bashrc
ln -is ~/.dotfiles/bash_profile ~/.bash_profile

ln -isn ~/.dotfiles/vim ~/.vim
ln -is ~/.dotfiles/vimrc ~/.vimrc

mkdir -p ~/.config/nvim
ln -is ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

ln -is ~/.dotfiles/tmux.conf ~/.tmux.conf

ln -is ~/.dotfiles/gitconfig ~/.gitconfig
ln -is ~/.dotfiles/gitignore ~/.gitignore
ln -isn ~/.dotfiles/git_template ~/.git_template

ln -is ~/.dotfiles/inputrc ~/.inputrc
ln -is ~/.dotfiles/ctags ~/.ctags

# vim backup to ~/tmp so make sure it exists
mkdir -p ~/tmp

mkdir -p ~/bin
ln -is ~/.dotfiles/bin/battery-status ~/bin
ln -is ~/.dotfiles/bin/ssh-status ~/bin
ln -is ~/.dotfiles/bin/slack-notify ~/bin

# osx specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -is ~/.dotfiles/tmux-osx.conf ~/.tmux-osx.conf

else # assume linux
  ln -is ~/.dotfiles/Xresources ~/.Xresources
  ln -is ~/.dotfiles/Xmodmap ~/.Xmodmap
  ln -is ~/.dotfiles/xinitrc ~/.xinitrc
  ln -is ~/.dotfiles/dmenurc ~/.dmenurc

  mkdir -p ~/.config/yabar/
  ln -is ~/.dotfiles/config/yabar/yabar.conf ~/.config/yabar

  mkdir -p ~/.config/i3/
  ln -is ~/.dotfiles/config/i3/config ~/.config/i3

  mkdir -p ~/.config/polybar/
  ln -is ~/.dotfiles/config/polybar/config ~/.config/polybar
  ln -is ~/.dotfiles/config/polybar/launch.sh ~/.config/polybar

  mkdir -p ~/.config/feh/
  ln -is ~/.dotfiles/config/feh/keys ~/.config/feh
fi
