-- Highlight the area that has been yanked
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_augroup("vdiff_colors", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
    group = "vdiff_colors",
    callback = function ()
        if vim.api.nvim_win_get_option(0, "diff")
            then
            vim.g.colors_name = "default"
        else
            vim.g.colors_name = "gruvbox"
        end
    end
})
