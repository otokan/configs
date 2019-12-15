set bg=dark
set hidden

set laststatus=2

nmap ,w :w<CR>
nmap ,9 :e ~/.vimrc<CR>
nmap ,0 :so ~/.vimrc<CR>

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set softtabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight nastyChars guibg=Red ctermbg=1 term=standout
autocmd BufWinEnter * syntax match nastyChars "[^\d32-\d127\d09]" containedin=ALL
" test: È
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'

set number relativenumber

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }
