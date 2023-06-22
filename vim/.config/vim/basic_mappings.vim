" Switch windows using ctrl and vim keys
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Move between buffers
nnoremap <C-PageUp> :bn<CR>
nnoremap <C-PageDown> :bp<CR>

" Split to the right
nnoremap <silent> <leader>vs :vsplit<CR>

" Split below
nnoremap <silent> <leader>hs :split<CR>

" Close splits
nnoremap <silent> <leader>cs :on<CR>

" Print the path to the current buffer
nnoremap <leader>p :!echo %:p<CR>

" Resize splits
nnoremap <silent> <A-h> :vertical resize -5<CR>
nnoremap <silent> <A-l> :vertical resize +5<CR>

" Move a line up or down with alt j and k
nmap <A-j> mz:m+<CR>`z
nmap <A-k> mz:m-2<CR>`z

" Make Y do what you would expect
nnoremap Y y$

" Keep cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Add relative lines jumps to the jumps List
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
