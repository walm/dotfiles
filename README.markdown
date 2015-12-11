My dotfiles
===========

I mainly use Arch and OS X. Code in go and ruby.

## Install

Simply do this

    curl -L "https://raw.github.com/walm/dotfiles/master/install.sh" | bash

Or clone this repo into `~/.dotfiles`

    git clone git@github.com:walm/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

## Arch requirements

    pacman -S vim tmux bash-completion autojump go ruby the_silver_searcher

## Mac requirements

[Homebrew](http://brew.sh/) and [Xcode](https://developer.apple.com/)

    brew install bash bash-completion
    brew install git git-flow
    brew install tmux reattach-to-user-namespace
    brew install vim ctags the_silver_searcher
    brew install autojump
    brew install rbenv ruby-build rbenv-ctags
    brew install go

#
## VIM

All plugins has been vendor in this repository. Why? it's faster to install and it just works, and Github seems to have the space to handle it ;)

## Docker

Use [docker toolbox](https://www.docker.com/toolbox) on OS X

Create a local machine named `local` by

    docker-machine create -d virtualbox \
        --virtualbox-memory 4096 \
        --virtualbox-cpu-count 2 \
        --virtualbox-disk-size 60000 \
        local

Add bash completions for docker

    brew tap homebrew/completions
    brew install homebrew/completions/docker-completion

## Golang

In vim, do `:GoInstallBinaries` to install tools [vim-go](https://github.com/fatih/vim-go) uses.

## Ruby

Install ruby and set default version

    rbenv install 2.2.3
    rbenv global 2.2.3

#
# License

This repository is MIT-licensed. You are awesome.

