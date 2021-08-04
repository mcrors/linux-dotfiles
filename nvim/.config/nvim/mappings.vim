" Switch windows using ctrl and vim keys
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" List buffers
nnoremap <silent> <leader>b :Buffers<CR>

" FZF fuzzy search files
nnoremap <silent> <C-p> :Files<CR>

" FZF fuzzy search open buffers
nnoremap <silent> <leader>l :Lines<CR>

" FZF fuzzy search current buffer
nnoremap <silent> <leader>f :BLines<CR>

" FZF git status
nnoremap <silent> <leader>g :GitFiles?<CR>

" Move between buffers 
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>

" Open all buffers as windows
nnoremap <silent> <leader>w :ball<CR>

" Print the path to the current buffer
nnoremap <leader>p :!echo %:p<CR>

" Maximize focused window
nnoremap <leader>o <C-W>o


" Toggle tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

" Toggle NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" Activate Airline theme gruvbox
nnoremap <silent> <A-a> :AirlineRefresh<CR>

" Close the current 
nnoremap <silent> <leader>q :bd<CR>

" reload the init file
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
