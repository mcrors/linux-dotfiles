-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

nvim_tree.setup {
    renderer = {
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = false,
    -- ignore_ft_on_setup = {
        -- "startify",
        -- "dashboard",
        -- "alpha",
    -- },
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 50,
        side = "left",
        number = false,
        relativenumber = false,
    },
    filters = {
        custom = { ".git$", "__pycache__", "node_modules", "*.pyc", ".pytest_cache", "*.class"},
        exclude = { ".github", ".vscode", ".env", ".gitignore", "middleware/target" }
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }

    }
}
