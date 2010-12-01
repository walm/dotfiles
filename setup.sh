#!/bin/bash

cd &&
[ -d '.dotfiles' ] || git clone git://github.com/walm/dotfiles.git ~/.dotfiles &&
  cd ~/.dotfiles
  rake install
