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
autocmd BufWinEnter * syntax match nastyChars " *$" containedin=ALL
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <f2> :bd!<cr>
nmap <f3> :qa!<cr>

augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END

if &diff
    syntax off
    nmap du :diffupdate<cr>
    nmap <F7> :wq! \| q!<cr>
    nmap <F6> :%diffget<cr>:wq! \| q!<cr>
endif

nmap S :%s@@g<LEFT><LEFT>
vmap S  :s@@g<LEFT><LEFT>

nmap <s-tab> <c-w><c-w>

nnoremap tn :tabnew<space>

nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>
nnoremap th :tabfirst<cr>
nnoremap tl :tablast<cr>
