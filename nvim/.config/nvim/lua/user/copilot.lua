function _G.copilot_enable()
  vim.g.copilot_enabled = true
  vim.cmd [[Copilot enable]]
  print("Copilot enabled")
end

function _G.copilot_disable()
  vim.g.copilot_enabled = false
  vim.cmd [[Copilot disable]]
  print("Copilot disabled")
end

-- Mapping the toggle function to <leader>c
vim.api.nvim_set_keymap('n', '<leader>cpe', ':lua _G.copilot_enable()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cpd', ':lua _G.copilot_disable()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cps', ':lua ()<CR>', { noremap = true, silent = true })

vim.keymap.set('i', '<C-L>', '<Plug>(copilot-next)')

