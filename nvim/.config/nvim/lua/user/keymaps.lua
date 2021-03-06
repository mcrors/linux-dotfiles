local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


------------
-- Normal --
------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Move between buffers
keymap("n", "<C-PageUp>", ":bprevious<CR>", opts)
keymap("n", "<C-PageDown>", ":bnext<CR>", opts)

-- Managed splits
keymap("n", "<leader>vs", ":vsplit<CR>", opts)
keymap("n", "<leader>hs", ":split<CR>", opts)

-- Rezise splits
keymap("n", "<A-h>", ":vertical resize -5<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +5<CR>", opts)

-- Close the current tab
keymap("n", "<C-w>", ":bd<CR>", opts)

-- Open a ternimal at the bottom, 
keymap("n", "<leader>z", ":new<CR>:terminal<CR>:resize 10<CR> :insert<CR>", opts)

-- Move a line up or down with alt j and k
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Make Y do what you would expect
keymap("n", "Y", "y$", opts)

-- Keep cursor centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Add relative lines jumps to the jumps List
-- TODO: figure our how to do the exp thing below
-- nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

-- Toggle nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope mappings
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>gg", "<cmd>lua require('telescope.builtin').git_status()<CR>", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>pp", "<cmd>lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<C-f>", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>to", "<cmd>lua require('telescope.builtin').treesitter(require('telescope.themes').get_dropdown())<CR>", opts)
keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())<CR>", opts)

-- Toggle class/module outline
keymap("n", "<leader>t", ":SymbolsOutline<CR>", opts)

-- Toggle git blame line
keymap("n", "gb", ":BlameLineToggle<CR>", opts)

------------
-- Insert --
------------
-- Move a line up or down with alt j and k
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)


------------
-- Visual --
------------
-- Move a line up or down with alt j and k
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)


-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
