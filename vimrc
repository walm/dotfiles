" based on http://github.com/twerth/dotfiles/raw/master/etc/vim/vimrc and some from PeepCode VIM videos
" -----------------------------------------------------------------------------
" |                            VIM Settings                                   |
" |                   (see gvimrc for gui vim settings)                       |
" |                                                                           |
" | Some highlights:                                                          |
" |   jj = <esc>  Very useful for keeping your hands on the home row          |
" |   ,n = toggle NERDTree off and on                                         |
" |                                                                           |
" |   C-Space = omni completion                                               |
" |   ,p = fuzzy find files with peepopen (only gui)                          |
" |   ,f or ,lf = fuzzy find all files                                        |
" |   ,b or ,lb = fuzzy find in all buffers                                   |
" |   ,d = diff current file with last save                                   |
" |   ,c = close current file/window                                          |
" |   ,w = strip trailing withspaces                                          |
" |   ,i = toggle invisibles                                                  |
" |   ,h = new horizontal window                                              |
" |   ,v = new vertical window                                                |
" |   ,ln = toggle linenumbers                                                |
" |   ,rn = toggle relativenumbers (great for motion commans)                 |
" |                                                                           |
" |   enter and shift-enter = adds a new line after/before the current line   |
" |                                                                           |
" |   Ttabs = set tab to real tabs                                            |
" |   Tspaces = set tab to 2 spaces (default)                                 |
" |   Stab = display or change tab/spacing settings                           |
" |                                                                           |
" | Put machine/user specific settings in ~/.vimrc.local                      |
" -----------------------------------------------------------------------------

set nocompatible

" load plugins with pathogen
filetype off
silent! call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)

" Default tab settings
command! -nargs=* Ttabs call Tabstyle_tabs()
function! Tabstyle_tabs()
  " Using 4 column tabs
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
endfunction

command! -nargs=* Tspaces call Tabstyle_spaces()
function! Tabstyle_spaces()
  " Use 2 spaces
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
  set expandtab
endfunction

function! Tabstyle_spaces4()
  " Use 4 spaces
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
endfunction

" default to 2 spaces Indenting
call Tabstyle_spaces()

" Set tabstop, softtabstop and shiftwidth to the same value ( from http://vimcasts.org/episodes/tabs-and-spaces/ )
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


" Scrollbars ******************************************************************
set sidescrolloff=2
set scrolloff=3
set numberwidth=4


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W<cr>
:noremap ,h :split^M^W^W<cr>


" Cursor highlights ***********************************************************
set cursorline
"set cursorcolumn


" Searching *******************************************************************
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase


" Colors **********************************************************************
" Switch on when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  "set t_Co=256 " 256 colors
  set background=dark
  syntax on " syntax highlighting
  colorscheme ir_black
  set hlsearch " highlight search
endif


" Status Line *****************************************************************
set showcmd
set showmode
"set number " show line number
set relativenumber " show relative linenumbers for easy motion commands
set ruler " show ruler
set laststatus=2 " show the status line all the time§

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


" Line Wrapping ***************************************************************
set wrap
set linebreak " Wrap at word


" Mappings ********************************************************************
let mapleader = "," " \ is the default leader character
imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
map <S-Enter> O<ESC> " Inserts new line without going into insert mode
map <Enter> o<ESC>
map <leader><space> :noh<cr> " Remove highlight from search
nnoremap <leader>a :Ack
noremap <leader>w :call <SID>StripTrailingWhitespaces()<cr>
noremap <leader>i :set list!<cr>
noremap <leader>ln :set number!<cr>
noremap <leader>rn :set relativenumber!<cr>

map <leader>c :close<cr>
map <leader>f <leader>lf
map <leader>b <leader>lb

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Cursor Movement *************************************************************
" Use hjkl keys (but we allow arrows in insert)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

map k gk
map j gj
map E ge
imap <up> <C-o>gk
imap <down> <C-o>gj
imap <left> <C-o>h
imap <right> <C-o>l


" Directories *****************************************************************
" Setup backup location and enable
"set backupdir=~/backup/vim
"set backup
set nobackup
set nowritebackup
set history=50 " keep 50 lines of command line history

" Set Swap directory
set directory=~/data/backup/vim/swap

" Sets path to directory buffer was loaded from
"autocmd BufEnter * lcd %:p:h

" File Stuff ******************************************************************
filetype plugin indent on
set fileencodings=utf-8,latin1
if has("autocmd")
  autocmd FileType html :set filetype=xhtml
  autocmd BufReadPost *.json :set filetype=javascript

  " set indent for filetypes
  autocmd FileType xhtml,javascript,css :call Tabstyle_spaces()

endif

" Session *********************************************************************
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize " Sets what is saved when you save a session
if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Misc ************************************************************************
set backspace=indent,eol,start
"set matchpairs+=<:>
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how
set hidden " Allow hidden unsaved buffers
set wildmenu
set autochdir " Change root to file
set wildmode=list:longest

"Source the vimrc file after saving it (from http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/)
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Invisible characters ********************************************************
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set list

" Mouse ***********************************************************************
"set mouse=a " Enable the mouse
"behave xterm
"set selectmode=mouse

" Omni Completion *************************************************************
" Remap code completion to Ctrl+Space 
if has("gui")
  inoremap <C-Space> <C-x><C-o>
else
  inoremap <Nul> <C-x><C-o>
endif
if has("autocmd")
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
endif " has(autocmd)

" -----------------------------------------------------------------------------
" |                              Plug-ins                                     |
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" |                             OS Specific                                   |
" |                      (GUI stuff goes in gvimrc)                           |
" -----------------------------------------------------------------------------

" Mac *************************************************************************
"if has("mac")
"
"endif

" -----------------------------------------------------------------------------
" |                               Startup                                     |
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" |                               Host specific                               |
" -----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"if hostname() == "foo"
" do something
"endif

" Example .vimrc.local:

"call Tabstyle_tabs()
"colorscheme ir_dark
"match LongLineWarning '\%120v.*'
"autocmd User ~/git/some_folder/* call Tabstyle_spaces() | let g:force_xhtml=1
