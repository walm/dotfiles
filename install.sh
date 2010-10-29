#!/bin/bash

cd &&
[ -d '.dotfiles' ] || git clone git://github.com/walm/dotfiles ~/.dotfiles &&
  cd ~/.dotfiles
  git submodule init &&
  git submodule update &&
  rake install
