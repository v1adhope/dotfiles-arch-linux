" ~/.vimrc

syntax on
set number
" Use space characters instead of tabs.
set expandtab
" Set tab width to n columns.
set tabstop=2
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap
" Ignore capital letters during search.
set ignorecase
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Use highlighting when doing a search.
set hlsearch
" Copy to system clipboard
xnoremap <silent> <C-@> :w !wl-copy<CR><CR>

