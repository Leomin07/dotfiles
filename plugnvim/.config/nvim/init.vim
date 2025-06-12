
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used with Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
" Theme
  Plug 'tomasiser/vim-code-dark'
  " Plug 'joshdick/onedark.vim',                  " Dark theme
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  Plug 'nvim-tree/nvim-web-devicons' " Icon

" File browser
  Plug 'preservim/nerdTree'                     " File browser
  Plug 'Xuyuanp/nerdtree-git-plugin'            " Git status
  Plug 'ryanoasis/vim-devicons'                 " Icon
  Plug 'unkiwii/vim-nerdtree-sync'              " Sync current file
  Plug 'jcharum/vim-nerdtree-syntax-highlight',
    \ {'branch': 'escape-keys'}

" File search
  Plug 'junegunn/fzf',
    \ { 'do': { -> fzf#install() } }            " Fuzzy finder
  Plug 'junegunn/fzf.vim'

" Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

" Terminal
  Plug 'voldikss/vim-floaterm'                  " Float terminal

" Code intellisense
  Plug 'neoclide/coc.nvim',
    \ {'branch': 'release'}                     " Language server protocol (LSP)
  Plug 'jiangmiao/auto-pairs'                   " Parenthesis auto
  Plug 'mattn/emmet-vim'
  Plug 'preservim/nerdcommenter'                " Comment code
  " Plug 'liuchengxu/vista.vim'                   " Function tag bar
  Plug 'alvan/vim-closetag'                     " Auto close HTML/XML tag
    \ {
      \ 'do': 'yarn install '
              \ .'--frozen-lockfile '
              \ .'&& yarn build',
      \ 'branch': 'main'
    \ }

" Code syntax highlight
  Plug 'yuezk/vim-js'                           " Javascript
  Plug 'MaxMEllon/vim-jsx-pretty'               " JSX/React
  Plug 'jackguo380/vim-lsp-cxx-highlight'       " C/C++
  " Plug 'uiiaoo/java-syntax.vim'                 " Java
  Plug 'sheerun/vim-polyglot'

" Debugging
  Plug 'puremourning/vimspector'                " Vimspector

" Source code version control
  Plug 'tpope/vim-fugitive'                     " Git infomation
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'                 " Git show changes
  Plug 'samoshkin/vim-mergetool'                " Git merge

" Fold
  Plug 'tmhedberg/SimpylFold'

" Format
  Plug 'stevearc/conform.nvim'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set theme
colorscheme onedark


" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
  execute 'source' setting_file
endfor

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Config mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
for keymap_file in split(glob(stdpath('config').'/config/*.vim'))
  execute 'source' keymap_file
endfor


