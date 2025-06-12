
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a                 " Enable mouse
set expandtab               " Tab setting
set tabstop=4               " Tab setting
set shiftwidth=4            " Tab setting
set listchars=tab:\¦\       " Tab charactor
set list
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=3        "
set number                  " Show line number
set ignorecase              " Enable case-sensitive

" Disable backup
set nobackup
set nowb
set noswapfile

" Optimize
set synmaxcol=3000    "Prevent breaking syntax hightlight when string too long. Max = 3000"
set lazyredraw
au! BufNewFile,BufRead *.json set foldmethod=indent " Change foldmethod for specific filetype

syntax on

" Enable copying from vim to clipboard
if has('win32')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
      \ | checktime
    \ | endif
autocmd FileChangedShellPost *
    \ echohl WarningMsg
    \ | echo "File changed on disk. Buffer reloaded."
    \ | echohl None



" Bật ngắt dòng tự động (Warp line)
set wrap

" Ngắt dòng tại ranh giới từ
set linebreak
