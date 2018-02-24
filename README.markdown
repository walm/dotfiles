My dotfiles
===========

[![Build Status](https://semaphoreci.com/api/v1/projects/370c2994-f7f7-4baf-a419-104ab82f56a6/632018/badge.svg)](https://semaphoreci.com/walm/dotfiles)

I mainly use Arch Linux and OS X.

## Install

Simply do this

    curl -L "https://raw.github.com/walm/dotfiles/master/install.sh" | bash

Or clone this repo into `~/.dotfiles`

    git clone git@github.com:walm/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

## Arch requirements

    pacman -S nvim tmux git bash-completion autojump go ruby the_silver_searcher

## Mac requirements

[Homebrew](http://brew.sh/) and [Xcode](https://developer.apple.com/)

    brew install bash bash-completion
    brew install git
    brew install tmux reattach-to-user-namespace
    brew install nvim the_silver_searcher
    brew install autojump
    brew install rbenv ruby-build rbenv-ctags
    brew install go


## Golang

In vim, do `:GoInstallBinaries` to install tools [vim-go](https://github.com/fatih/vim-go) uses.

## Ruby

Install ruby and set default version

    rbenv install 2.2.3
    rbenv global 2.2.3

#
# License

This repository is MIT-licensed. You are awesome.

