" ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'

call plug#end()

" True color 24-bit
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme onedark

" Line numbering
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

