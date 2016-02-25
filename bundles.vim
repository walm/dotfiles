set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" General enhancements
Plugin 'tpope/vim-sensible.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-tbone'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'tsaleh/vim-align'
Plugin 'kchmck/vim-coffee-script'
Plugin 'SirVer/ultisnips'
Plugin 'cespare/vim-toml'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'craigemery/vim-autotag'
Plugin 'airblade/vim-gitgutter'
Plugin 'kana/vim-textobj-user'
Plugin 'sjl/gundo.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/dbext.vim'
Plugin 'changa/psql.vim'

" Web specific
Plugin 'wavded/vim-stylus'

" Go specific
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'garyburd/go-explorer'

" Ruby specific
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-bundler.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-rake.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nelstrom/vim-textobj-rubyblock'

" Colorschemes
Plugin 'chriskempson/vim-tomorrow-theme'

call vundle#end()

filetype plugin indent on
