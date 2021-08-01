" Switch windows using ctrl and vim keys
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" List buffers
nnoremap <leader>b :Buffers<CR>
nnoremap <C-p> :Files<CR>

" Move between buffers 
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>

" Open all buffers as windows
nnoremap <silent> <leader>w :ball<CR>
" Print the path to the current buffer
nnoremap <leader>p :!echo %:p<CR>

" Maximize focused window
nnoremap <C-O> <C-W>o

" Toggle Nerd tree file explorer
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" Toggle tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

" reload the init file
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
