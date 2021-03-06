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
nnoremap <silent> <C-f> :BLines<CR>

" FZF git status
nnoremap <silent> <leader>g :GitFiles?<CR>

" Use FZF to jump around Windows
nnoremap <silent> <C-t> :Windows<CR>

" ripgrep project
nnoremap <silent> <C-r> :Rg<CR>

" fzf tags in the current buffer
nnoremap <silent> bt :BTags<CR>

" git blame toggle
nnoremap <silent> gb :BlamerToggle<CR>

" Open commits for the current buffer
nnoremap <silent> gc :BCommit<CR>

" Move between buffers
nnoremap <C-PageUp> :bp<CR>
nnoremap <C-PageDown> :bn<CR>

" Open all buffers as windows
"nnoremap <silent> <leader>w :ball<CR>

" Split to the right
nnoremap <silent> <leader>vs :vsplit<CR>
" Split below
nnoremap <silent> <leader>hs :split<CR>

" Close splits
nnoremap <silent> <leader>cs :on<CR>


" Print the path to the current buffer
nnoremap <silent> <leader>p :!echo %:p<CR>

" Maximize focused window
nnoremap <leader>o <C-W>o

" Resize splits
nnoremap <silent> <A-h> :vertical resize -5<CR>
nnoremap <silent> <A-l> :vertical resize +5<CR>

" Close current tab
nnoremap <silent> <C-w> :tabclose<CR>

" Move to next tab
nnoremap <silent> <C-right> :tabnext<CR>

" Move to prev tab
nnoremap <silent> <C-left> :tabprevious<CR>

" Toggle tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR> <C-W>l

" Toggle NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" Activate Airline theme gruvbox
nnoremap <silent> <A-a> :AirlineRefresh<CR>

" Close the current
nnoremap <silent> <leader>q :bd<CR>

" reload the init file
nnoremap <silent> <leader>s :source ~/.config/nvim/init.vim<CR>

" open a terminal in horizontal split
nnoremap <silent> <leader>z :new<CR>:terminal<CR>:resize 10<CR>

" Expand
imap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-s>'
smap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-s>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Use Ctrl-Enter to bring up completetion suggestions
" inoremap jj <C-x><C-o>
" inoremap <Tab><Tab> <C-x><C-o>

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"

" Move a line up or down with alt j and k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Surround mappings
nnoremap <silent> <C-"> :ysiw"

" Format json content
nnoremap <silent> bj :%!jq . <CR>

" Make Y do what you would expect
nnoremap Y y$

" Keep cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Add relative lines jumps to the jumps List
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

