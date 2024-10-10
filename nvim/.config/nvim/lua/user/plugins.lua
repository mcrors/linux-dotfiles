local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"    -- Have packer manage itself
    use "nvim-lua/popup.nvim"       -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"     -- Useful lua functions used by lots of plugins
    use "gruvbox-community/gruvbox" -- colorscheme
    use "savq/melange-nvim"         -- colorscheme

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- status line plugins and themes
    use "vim-airline/vim-airline"
    use "vim-airline/vim-airline-themes"

    use "jiangmiao/auto-pairs" -- Does what it says, auto-pairs

    -- go stuff
    -- This was commented out as it wasn't working with neovim go dap
    -- TODO: see if you can get this working with go dap
    use "ray-x/go.nvim"
    use 'ray-x/guihua.lua'

    -- Add a directory tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- Completion stuff
    use "hrsh7th/nvim-cmp"    -- The completion plugin
    use "hrsh7th/cmp-buffer"  -- buffer completions
    use "hrsh7th/cmp-path"    -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp"
    use { 'saadparwaiz1/cmp_luasnip' }

    -- snippets stuff
    use { 'L3MON4D3/LuaSnip' }
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP

    use {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
    }
    use "williamboman/mason-lspconfig.nvim"
    use "kevinhwang91/nvim-bqf" -- This makes the go-to-references window better

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- DAP debugger stuff
    use "mfussenegger/nvim-dap" -- neovim DAP client
    use 'leoluz/nvim-dap-go'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use { 'nvim-telescope/telescope-dap.nvim' }
    use { 'theHamsta/nvim-dap-virtual-text' }

    -- Comment code
    use "terrortylor/nvim-comment"

    -- Class outline viewer
    use "simrat39/symbols-outline.nvim"

    -- git stuff
    use "tpope/vim-fugitive"
    use "f-person/git-blame.nvim"
    use "airblade/vim-gitgutter"

    -- github co-pilot
    use "github/copilot.vim"

    -- View git diffs better
    use "sindrets/diffview.nvim"

    -- Some ansible highlighting
    use "pearofducks/ansible-vim"

    -- Draw some simple ascii diagrams in vim
    use "jbyuki/venn.nvim"

    -- ripgrep in vim
    use "jremmen/vim-ripgrep"

    -- http client
    use {
        "rest-nvim/rest.nvim",
        requires = { "j-hui/fidget.nvim" }
    }


    -- surround
    use "tpope/vim-surround"

    -- highlighting in log files
    use {
        'fei6409/log-highlight.nvim',
        config = function()
            require('log-highlight').setup {}
        end,
    }

    -- having a line for tab spaces
    use "Yggdroot/indentLine"

    -- helm template syntax highlighting
    use "towolf/vim-helm"

    -- rsync
    use { 'kenn7/vim-arsync',
        requires = {
            { 'prabirshrestha/async.vim' }
        }
    }

    -- formatter
    use "stevearc/conform.nvim"

    -- Automatically set up our configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
