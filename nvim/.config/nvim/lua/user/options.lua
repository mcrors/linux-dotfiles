-- for help with options enter :help options
vim.opt.syntax = "enable"
vim.opt.hidden = true            					-- Required to keep multiple buffers open multiple buffers
vim.opt.swapfile = false 	 						-- Open new buffers without creating a swap file for it
vim.opt.wrap = false 		 						-- Display long lines as just one line
vim.opt.encoding = "utf-8"	 						-- The encoding displayed
vim.opt.pumheight = 10           					-- Makes popup menu smaller
vim.opt.fileencoding = "utf-8"   					-- The encoding written to file
vim.opt.ruler = true 		 						-- Show the cursor position all the time
vim.opt.cmdheight = 2            					-- More space for displaying messages
vim.opt.iskeyword = vim.opt.iskeyword + "-"         -- treat dash separated words as a word text object
vim.opt.mouse = "a"                             	-- Enable your mouse
vim.opt.splitbelow = true                         	-- Horizontal splits will automatically be below
vim.opt.splitright = true   						-- Vertical splits will automatically be to the right
vim.opt.fileencoding = "utf-8"                      -- the encoding written to a file
vim.opt.ignorecase = true                           -- ignore case in search patterns
vim.opt.conceallevel = 3                            -- conceal markdown stuff
vim.opt.tabstop = 4                             	-- Insert 4 spaces for a tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4								-- Change the number of space characters inserted for indentation
vim.opt.hlsearch = false							-- Don't hightlight searched items forever
vim.opt.smarttab = true								-- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true							-- Converts tabs to spaces
vim.opt.smartindent = true							-- Makes indenting smart
vim.opt.autoindent = true							-- Good auto indent
vim.opt.laststatus = 2								-- Always display the status line
vim.opt.number = true								-- line numbers
vim.opt.relativenumber = true						-- add relative lines
vim.opt.cursorline = true                           -- Enable highlighting of the current line
vim.opt.showtabline = 4                             -- Always show tabs
vim.opt.showmode = false                            -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300                            -- Faster completion
vim.opt.timeoutlen = 500                            -- By default timeoutlen is 1000 ms
vim.opt.clipboard = "unnamedplus"                   -- Copy paste between vim and everything else
vim.opt.scrolloff = 8                               -- Add space at the bottom
vim.opt.colorcolumn = {"88"}                        -- Add a column at 79 so you don't go over that with your code.
vim.opt.modifiable = true
vim.opt.completeopt = {
    "menu", "noinsert", "noselect", "preview"
}
vim.opt.wildmenu = true
vim.opt.splitright = true                           -- force all vertical splits to go to the right of current window
vim.opt.splitbelow = true                          -- force all horizontal splits to go below current window
vim.opt.signcolumn = "yes"                         -- always show the sign column, otherwise it would shift the text each time
vim.opt.foldenable = false                         -- I hate folding
vim.opt.shortmess:append "c"
vim.g.indentLine_char =  '⦙'

-- don't continue comments automatically on new lines
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- set some options that were causing warnings in checkhealth
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- set some global go options
vim.g.go_fmt_command = "goformat"
