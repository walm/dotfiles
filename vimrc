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
" |                                                                           |
" |   hh = inserts '=>'                                                       |
" |   aa = inserts '@'                                                        |
" |                                                                           |
" |   enter and shift-enter = adds a new line after/before the current line   |
" |                                                                           |
" |   Ttabs = set tab to real tabs                                            |
" |   Tspaces = set tab to 2 spaces                                           |
" |   Stab = display or change tab/spacing settings                           |
" |                                                                           |
" | Put machine/user specific settings in ~/.vimrc.local                      |
" -----------------------------------------------------------------------------

set nocompatible

" load plugins with pathogen
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
  syntax on
  set hlsearch " highlight search
endif


" Status Line *****************************************************************
set showcmd
set showmode
set number " show line number
set ruler " Show ruler
set laststatus=2 " show the status line all the time§
"set ch=2 " Make command line two lines high
"match LongLineWarning '\%120v.*' " Error format when a line is longer than 120

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


" Line Wrapping ***************************************************************
set wrap
set linebreak " Wrap at word


" Mappings ********************************************************************
let mapleader = "," " \ is the default leader character
imap jj <Esc> "Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
imap uu _
imap hh =>
imap aa @
map <S-Enter> O<ESC> " inserts new line without going into insert mode
map <Enter> o<ESC>
"set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)
noremap <Leader>w :call <SID>StripTrailingWhitespaces()<CR>
noremap <Leader>i :set list!<CR> " Toggle invisible chars
noremap <Leader>c :close<CR> " close a window
map <Leader>f <Leader>lf
map <Leader>b <Leader>lb

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
" Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge


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

  " set indent for filetypes
  autocmd FileType xhtml,javascript,css :Tspace

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
"set wildmode=list:longest

" Source the vimrc file after saving it (from http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/)
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
