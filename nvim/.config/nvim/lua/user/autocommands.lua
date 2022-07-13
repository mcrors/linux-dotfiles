-- Highlight the area that has been yanked
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function() vim.highlight.on_yank() end,
})

-- Don't show blame lines on file open
-- vim.api.nvim_create_augroup("disable_blameline", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--     group = "disable_blameline",
--     callback = function () require("blame_line").disable() end
-- })
