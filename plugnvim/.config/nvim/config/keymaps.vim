"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Resize pane

lua print('Neovim started...')
" Đặt phím Space làm Leader key
let g:mapleader = " "

nmap <M-Right> :vertical resize +1<CR>
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nmap /\ :noh<CR>

" Windows
" Save file (Ctrl + S)
noremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>

" Quit Vim (<Leader>qq)
nnoremap <Leader>qq :qa<CR>
" Close window
nnoremap <silent> <leader>wc :q<CR>


" Đóng buffer hiện tại (tương tự 'đóng tab' trong các IDE khác)
nnoremap <leader>q :bd<CR>
" Buộc đóng buffer hiện tại (bỏ qua thay đổi chưa lưu)
nnoremap <leader>Q :bd!<CR>



" ======== FZF Key Mappings ========

" Tìm kiếm File
" Sử dụng <Leader>f để tìm file (phổ biến)
nnoremap <Leader>ff :Files<CR>

" Tìm kiếm Nội dung (grep/ripgrep)
" Sử dụng <Leader>g để tìm nội dung
nnoremap <Leader>fg :Rg<CR>

" Tìm kiếm Buffers (các file đang mở)
nnoremap <Leader>fb :Buffers<CR>

" Tìm kiếm Lịch sử lệnh của Vim
nnoremap <Leader>h :History<CR>

" Tìm kiếm Git Commits (trong project hiện tại)
nnoremap <Leader>gc :Commits<CR>

" Tìm kiếm Git Commits (trong buffer hiện tại)
nnoremap <Leader>bc :BCommits<CR>

" Tìm kiếm các dòng trong quickfix list
nnoremap <Leader>qf :Crouch<CR> " fzf#vim#Crouch là một cách để tìm trong quickfix list




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkey to manage Floaterm terminals
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a new terminal 
nnoremap <silent> <leader>to    :FloatermNew<CR>
tnoremap <silent> <leader>to    <C-\><C-n>:FloatermNew<CR>

" Kill current terminal 
nnoremap <silent> <leader>tk :FloatermKill<CR>:FloatermPrev<CR>
tnoremap <silent> <leader>tk <C-\><C-n>:FloatermKill<CR>:FloatermPrev<CR>

" Navigation next and previous terminal 
nnoremap <silent> <leader>tn :FloatermNext<CR>
tnoremap <silent> <leader>tn <C-\><C-n>:FloatermNext<CR>
nnoremap <silent> <leader>tp :FloatermPrev<CR>
tnoremap <silent> <leader>tp <C-\><C-n>:FloatermPrev<CR>

" Toggle terminal
nnoremap <silent> <leader>tt :FloatermToggle<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:FloatermToggle<CR>

" Focus terminal 
nnoremap <silent> <leader>tf <C-\><C-n><C-W><Left>
tnoremap <silent> <leader>tf <C-\><C-n><C-W><Left>


nnoremap <leader>w :tabclose<CR>
