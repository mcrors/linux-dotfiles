-- Highlight the area that has been yanked
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_augroup("remove_whitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "remove_whitespace",
    pattern = "*",
    command = [[:keepjumps keeppatterns %s/\s\+$//e]]
})
