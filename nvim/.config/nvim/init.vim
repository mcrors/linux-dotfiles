if !exists('g:vscode')
    call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'gruvbox-community/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'scrooloose/nerdcommenter'
    Plug 'pearofducks/ansible-vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'APZelos/blamer.nvim'
    Plug 'mboughaba/i3config.vim'
    call plug#end()

    " set leader key
    let g:mapleader = "\<Space>"

    "Key-bindings
    let mapleader=" "

    "Color Settings
    colorscheme gruvbox
    set background=dark
    set termguicolors
    let g:limelight_conceal_ctermfg = 240
    let g:limelight_conceal_guifg = '#777777'
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
    hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f
    hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac
    hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0
    hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2
    let g:airline_theme='base16_gruvbox_dark_soft'

    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'

    " Setup neovim lsp for python
  "  lua << EOF
  "      require'lspconfig'.pyright.setup{}
"EOF

    "source files for non vscode setup
    source ~/.config/nvim/autocmds.vim
    source ~/.config/nvim/plug-config/devicons.vim
    source ~/.config/nvim/plug-config/nerdtree.vim
    source ~/.config/nvim/plug-config/fzf.vim
    source ~/.config/nvim/plug-config/rnvimr.vim
    source ~/.config/nvim/plug-config/lsp.vim
    source ~/.config/nvim/plug-config/gitblamer.vim
    source ~/.config/nvim/mappings.vim

else
    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction

    function! s:vscodeCommentary(...) abort
        if !a:0
            let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
            return 'g@'
        elseif a:0 > 1
            let [line1, line2] = [a:1, a:2]
        else
            let [line1, line2] = [line("'["), line("']")]
        endif

        call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
    endfunction

    function! s:openVSCodeCommandsInVisualMode()
        normal! gv
        let visualmode = visualmode()
        if visualmode == "V"
            let startLine = line("v")
            let endLine = line(".")
            call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
        else
            let startPos = getpos("v")
            let endPos = getpos(".")
            call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
        endif
    endfunction

    function! s:openWhichKeyInVisualMode()
        normal! gv
        let visualmode = visualmode()
        if visualmode == "V"
            let startLine = line("v")
            let endLine = line(".")
            call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
        else
            let startPos = getpos("v")
            let endPos = getpos(".")
            call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
        endif
    endfunction

    " Better Navigation
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

    nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

    " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
    xnoremap <expr> <C-/> <SID>vscodeCommentary()
    nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

    nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

    nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
    xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

    xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine

    " Simulate same TAB behavior in VSCode
    nmap <Tab> :Tabnext<CR>
    nmap <S-Tab> :Tabprev<CR>
endif

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set noswapfile                          " Open new buffers without creating a swap file for it
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 4 spaces for a tab
set softtabstop=4
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set nohlsearch                          " Don't hightlight searched items forever
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set listchars                           " show spaces
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting se/aart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set relativenumber                      " Add relative lines
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=4                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set scrolloff=8                         " Add space at the bottom
set colorcolumn=79                      " Add a column at 90 so you don't go over that with your code.
set modifiable
set completeopt=menu,noinsert,noselect,preview
