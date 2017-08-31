" vim: nowrap foldmethod=marker foldlevel=0

" Plugins {{{
" install vim-plug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kylef/apiblueprint.vim'

" Go development
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

" Javascript
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'

" Colorschemes
Plug 'chriskempson/vim-tomorrow-theme'

call plug#end()
" }}}

let mapleader = ","
set hidden
set ruler              " show the cursor position all the time
set undofile           " keep an undo file (undo changes after closing)
set noswapfile         " do not write swap files
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·,eol:¬
set list!              " show invisible characters by default
set clipboard+=unnamedplus " always use clipboard
set pastetoggle=<F2>
set completeopt-=preview  " disable preview for completion
set scrolloff=1        " nr of lines to keep above and below cursor
set splitbelow         " new window split below

" Colorscheme and highlighting {{{
colorscheme Tomorrow-Night-Bright

syntax on
set showmatch          " highlight matching [{()}]
set cursorline         " highlight current line

" highlighting strings inside comments.
let c_comment_strings=1

" underline misspelled words
hi! SpellBad cterm=NONE,undercurl term=NONE,undercurl ctermfg=NONE ctermbg=NONE guisp=DarkRed

" transparent background
hi! Normal ctermbg=none
" }}}

" Functions {{{

" strip trailing whitespaces (mapped to <leader><BS>)
function! StripTrailingWhitespaces()
  " preparation save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunc

" use 2 spaces for indenting
function! TabstyleSpaces()
  set softtabstop=2 " when hitting <BS>, pretend like a tab is removed, even if spaces
  set shiftwidth=2  " number of spaces to use for autoindenting
  set tabstop=2     " a tab is two spaces
  set expandtab     " expand tabs by default
  set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
endfunc
command! -nargs=* Tspaces call TabstyleSpaces()

" using 4 column tabs for indenting
function! TabstyleTabs()
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
  set noshiftround
endfunc
command! -nargs=* Ttabs call TabstyleTabs()

call TabstyleSpaces() " default to 2 spaces
" }}}

" EasyMotion settings {{{
map m <Plug>(easymotion-prefix)
map m/ <Plug>(easymotion-sn)
" }}}

" AirLine settings {{{
let g:airline_theme='zenburn'
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" }}}

" NERDTree settings {{{
map <leader>n :NERDTreeToggle<CR>
" show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
" don't display these kinds of files
let NERDTreeIgnore=[ '\~$', '\.obj$', '\.o$', '\.so$', '^\.git$', '\.DS_Store' ]
" }}}

" vim-go settings {{{
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"

augroup goconf
  au!

  " show a list of interfaces which is implemented by the type under your cursor
  au FileType go nmap <Leader>S <Plug>(go-implements)

  " show type info for the word under your cursor
  au FileType go nmap <Leader>I <Plug>(go-info)

  " open the relevant Godoc for the word under the cursor
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

  au FileType go nmap <leader>B <Plug>(go-build)
  au FileType go nmap <leader>R <Plug>(go-run)
  au FileType go nmap <leader>T <Plug>(go-test)
  au FileType go nmap <leader>C <Plug>(go-coverage)
augroup END
" }}}

" fugitive settings {{{
" easy navigate in git history
au User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nmap <buffer> .. :edit %:h<CR> |
  \ endif

" delete fugitive buffers that are hidden (http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/)
au BufReadPost fugitive://* set bufhidden=delete
" }}}

" Key mappings {{{
" leave insert mode easy
map <C-c> <Esc>
inoremap jk <Esc>

" write with W also
command! W w

" don't use Ex mode, use Q for formatting
noremap Q gq

" remove highlight from search and turn of spelling, simply no highlights
nnoremap <leader><space> :exe "nohlsearch \| set nospell"<CR>

" stripe whitespaces
map <leader><BS> :call StripTrailingWhitespaces()<CR>

" trigger neomake
map <leader>c :Neomake<CR>

" toggle invisibles
map <leader>i :set list!<CR>

" select text just pasted
noremap gV `[v`]

" toggle gundo
"nnoremap <leader>u :GundoToggle<CR>

" file / buffer navi
" %% from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"cmap %% <C-R>=expand('%:h').'/'<CR>
"map <leader>e :edit %%
"map <leader>v :view %%
"map <leader>t :TagbarToggle<CR>

" move vertically by visual line
"nnoremap j gj
"nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" easy jumping with Swedish keyboard layout
map <C-h> <C-t>
map <C-l> <C-]>

" tag completion on Swedish keyboard is a pain
imap <C-x><C-m> <C-x><C-]>

" easy buffer jumping
nmap bn :bn<CR>
nmap bp :bp<CR>

" jump between current and last buffer/file
nmap <leader><leader> <C-^>

" bubble single lines (using tpope/vim-unimpaired)
nmap <C-k> [e
nmap <C-j> ]e

" bubble multiple lines (using tpope/vim-unimpaired)
vmap <C-k> [egv
vmap <C-j> ]egv
" }}}

" FZF settings {{{
map <leader>f :Files<CR>
map <leader>gf :GFiles<CR>
map <leader>b :Buffers<CR>
map <leader>a :Ag

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

" File types {{{
filetype plugin indent on

augroup vimrcEx
  au!

  " text files set 'textwidth' to 78 characters.
  au FileType text setlocal textwidth=78

  " when editing a file, always jump to the last known cursor position.
  au BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

augroup END

augroup fileconf
  au!
  au BufRead,BufNewFile *.psql set ft=sql
  au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru} set ft=ruby
  au BufReadPost *.go :set nolist " hide invisible when working in go, gofmt clean things up ;)
augroup END
" }}}

" -- from template defaults

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif

