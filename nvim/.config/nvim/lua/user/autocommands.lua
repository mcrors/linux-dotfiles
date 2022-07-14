-- Highlight the area that has been yanked
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function() vim.highlight.on_yank() end,
})

-- vim.api.nvim_create_augroup("vdiff_colors", { clear = true })
-- vim.api.nvim_create_autocmd("BufNewFile", {
--     group = "vdiff_colors",
--     callback = function()
--         if vim.api.nvim_win_get_option(0, "diff")
--         then
--             vim.cmd "colorscheme default"
--         else
--             vim.cmd "colorscheme gruvbox"
--             vim.cmd "set background=dark"
--             vim.cmd "set termguicolors"
--             vim.cmd "let g:limelight_conceal_ctermfg = 240"
--             vim.cmd "let g:limelight_conceal_guifg = '#777777'"
--             vim.cmd "hi! Normal ctermbg=NONE guibg=NONE"
--             vim.cmd "hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE"
--         end
--     end
-- })
