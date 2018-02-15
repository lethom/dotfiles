call plug#begin('~/.config/nvim/plugged')
  Plug 'robertmeta/nofrils'
  Plug 'scrooloose/nerdcommenter'
  Plug 'airblade/vim-gitgutter'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'kien/ctrlp.vim'
  Plug 'raichoo/purescript-vim'
  Plug 'ogma-project/vim-ogmarkup'
call plug#end()

" GENERAL CONFIGURATION
set expandtab
set tabstop=2
set shiftwidth=2
set ai
set backspace=2
set textwidth=80
set cursorline
set cc=80
set mouse=a
"set t_Co=256
syntax on
let mapleader=','
set number

" Terminal
tnoremap <Esc> <C-\><C-n>

" THEME
set bg=dark
let g:nofrils_strbackgrounds=1
let g:nofrils_heavycomments=1
colorscheme nofrils-dark

highlight LineNr ctermfg=DarkGray

" resizing
noremap <up>    :resize +2<cr>
noremap <down>  :resize -2<cr>
noremap <right> :vertical resize +2<cr>
noremap <left>  :vertical resize -2<cr>

" YCM
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
let g:ycm_autoclose_preview_window_after_completion = 1

autocmd Filetype haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1

nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>

autocmd Filetype haskell nnoremap <leader>hs :%!stylish-haskell<CR>
autocmd Filetype haskell nnoremap <leader>hi :GhcModType!<CR>
autocmd Filetype haskell nnoremap <leader>hc :GhcModClear<CR>
autocmd Filetype haskell nnoremap <leader>ht :GhcModTypeInsert!<CR>

autocmd! BufWritePost Filetype haskell Neomake

hi Normal ctermbg=None
hi LineNr ctermbg=None

" BÉPO
let g:bepo = 1

function! BepoLayout()
  noremap é w
  noremap É W

  onoremap aé aw
  onoremap aÉ aW
  onoremap ié iw
  onoremap iÉ iW

  noremap w <C-w>
  noremap W <C-w><C-w>

  noremap t h
  noremap n l

  noremap s gj
  noremap r gk

  noremap T H
  noremap N L

  noremap S J
  noremap R K

  noremap zs zj
  noremap zt zk

  noremap gb gT
  noremap gé gt

  noremap j t
  noremap J T

  noremap l r
  noremap L R

  noremap « <
  noremap » >

  noremap m n
  noremap M N

  noremap ws <C-w>j
  noremap wr <C-w>k
  noremap wt <C-w>h
  noremap wn <C-w>l
  noremap w<SPACE> :split<CR>
  noremap w<CR> :vsplit<CR>
endfunction

if g:bepo
  call BepoLayout()
endif

source ~/.init.vim
