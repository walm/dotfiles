" based on http://github.com/twerth/dotfiles/raw/master/etc/vim/gvimrc
" -----------------------------------------------------------------------------  
" |                            VIM Settings                                   |
" |                              GUI stuff                                    |
" |                                                                           |
" | Some highlights:                                                          |
" |                                                                           |
" |       ,p = peepopen for nice file find                                    |
" |                                                                           |
" -----------------------------------------------------------------------------  


" OS Specific *****************************************************************
if has("gui_macvim")

  set fuoptions=maxvert,maxhorz " fullscreen options (MacVim only), resized window when changed to fullscreen
  set guifont=Monaco:h13
  set guioptions-=T " remove toolbar
  "set stal=2 " turn on tabs by default

  noremap <Leader>p :PeepOpen<CR>

elseif has("gui_gtk2")

  set guifont=Monaco
  set guioptions-=T " remove toolbar

elseif has("x11")
elseif has("gui_win32")
end

" General *********************************************************************
set anti " Antialias font
"set transparency=15 "in %

" Default size of window
set columns=179
set lines=50

" Tab headings 
set gtl=%t gtt=%F
