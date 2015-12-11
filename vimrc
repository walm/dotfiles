" vim: nowrap foldmethod=marker foldlevel=0

source ~/.dotfiles/bundles.vim

let mapleader = ","

" Personal preferences not set in sensible.vim
set encoding=utf-8        " always utf-8
set history=5000
set hidden
set nojoinspaces
set cursorline            " highlight current line
set hlsearch              " highlight matches
set showmatch             " highlight matching [{()}]
set lazyredraw            " don't update the display while executing macros
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·,eol:¬
set list!                 " show invisible characters by default
set noswapfile            " do not write annoying swap files
set equalalways           " multiple windows, when created, are equal in size
set splitbelow splitright " put new window below or to right
set clipboard=unnamedplus " default to "+ register
set pastetoggle=<F2>
set completeopt-=preview  " disable preview for completion


" Colorscheme {{{
silent! colorscheme Tomorrow-Night-Bright
silent! syntax enable

" underline misspelled words
silent! hi! SpellBad cterm=NONE,undercurl term=NONE,undercurl ctermfg=NONE ctermbg=NONE guisp=DarkRed
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

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
  endfunc
" }}}

" Indentation functions {{{
function! TabstyleSpaces()
  " Use 2 spaces
  set softtabstop=2 " when hitting <BS>, pretend like a tab is removed, even if spaces
  set shiftwidth=2  " number of spaces to use for autoindenting
  set tabstop=2     " a tab is two spaces
  set expandtab     " expand tabs by default
  set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
endfunc
command! -nargs=* Tspaces call TabstyleSpaces()

function! TabstyleTabs()
  " Using 4 column tabs
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
  set noshiftround
endfunc
command! -nargs=* Ttabs call TabstyleTabs()

call TabstyleSpaces() " default to 2 spaces
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

" Syntastic settings {{{
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'm', 'coffee', 'json', 'js', 'css', 'sass', 'scss'],
                           \ 'passive_filetypes': ['html'] }
if executable('sassc')
  let g:syntastic_scss_checkers = ['sassc']
endif
" }}}

" vim-go settings {{{
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

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

" CtrlP settings {{{
map <leader>f :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_root_markers = ['root.dir']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn|tmp|grunt|vagrant)$|\v[\/](doc|dist|tmp|build|log|reports|coverage|node_modules|bower_components|vendor)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
if executable('ag')
  " use The Silver Searcher for speed
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}

" EasyMotion settings {{{
map m <Plug>(easymotion-prefix)
map m/ <Plug>(easymotion-sn)
" }}}

" Key mappings {{{
" leave insert mode easy
map <C-c> <Esc>
inoremap jk <Esc>

" write with W also
command! W w

" remove highlight from search and turn of spelling, simply no highlights
nnoremap <leader><space> :exe "nohlsearch \| set nospell"<CR>

" stripe whitespaces
map <leader><BS> :call StripTrailingWhitespaces()<CR>

" toggle invisibles
map <leader>i :set list!<CR>

" select text just pasted
noremap gV `[v`]

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag

" file / buffer navi
" %% from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
cmap %% <C-R>=expand('%:h').'/'<CR>
map <leader>e :edit %%
map <leader>v :view %%
map <leader>t :TagbarToggle<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

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

" File types {{{
augroup fileconf
  au!
  au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru} set ft=ruby
  au BufReadPost *.rb :set norelativenumber " speed up syntax highlighting for ruby
  au BufReadPost *.go :set nolist " hide invisible when working in go, gofmt clean things up ;)
  au BufWritePre *.rb,*.js,*.coffee,*.txt,*.java,*.md,*.yml :call StripTrailingWhitespaces()
augroup END
" }}}

" Tmux {{{
" allows cursor change in tmux mode, ex for insert mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" host specific
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
