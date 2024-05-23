set ai
set number
syntax on
set ruler
set ts=4
set sw=4
highlight Comment ctermfg=green
set backspace=indent,eol,start
set linebreak
set noerrorbells

" vim-plug
" Plugins below are mainly for creative writing
" I should probably create a separate vim config file for coding
call plug#begin()
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
call plug#end()

" seoul256 Config
let g:seoul256_background = 236
colo seoul256

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

let g:goyo_width = 60
let g:limelight_default_coefficient = 0.7

map <leader>gy :Goyo<CR>
map <leader>ll :Limelight!!<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!



