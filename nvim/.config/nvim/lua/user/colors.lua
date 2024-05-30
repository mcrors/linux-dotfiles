vim.g.colors_name = "gruvbox"
-- why did this change ffs
vim.cmd('colorscheme gruvbox')

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.limelight_conceal_ctermfg = 240
vim.g.limelight_conceal_guifg = '#777777'
vim.cmd "hi! Normal ctermbg=NONE guibg=NONE"
vim.cmd "hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE"
vim.cmd "hi! TSError ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE"

-- vim.cmd "hi DiffAdd      cterm=bold ctermfg=10 ctermbg=15 gui=none guifg=bg guibg=Red"
-- vim.cmd "hi DiffChange   cterm=bold ctermfg=10 ctermbg=15 gui=none guifg=bg guibg=Red"
-- vim.cmd "hi DiffDelete   cterm=bold ctermfg=10 ctermbg=15 gui=none guifg=bg guibg=Red"
-- vim.cmd "hi DiffText     cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red"
