vim.g.colors_name = "gruvbox"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.limelight_conceal_ctermfg = 240
vim.g.limelight_conceal_guifg = '#777777'
vim.cmd "hi! Normal ctermbg=NONE guibg=NONE"
vim.cmd "hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE"
vim.cmd "hi DiffAdd      gui=none    guifg=NONE          guibg=#bada9f"
vim.cmd "hi DiffChange   gui=none    guifg=NONE          guibg=#e5d5ac"
vim.cmd "hi DiffDelete   gui=bold    guifg=#ff8080       guibg=#ffb0b0"
vim.cmd "hi DiffText     gui=none    guifg=NONE          guibg=#8cbee2"
