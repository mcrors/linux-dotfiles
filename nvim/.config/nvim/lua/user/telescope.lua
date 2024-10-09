local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")
local Job = require("plenary.job")

Git_log_picker = function(opts)
    opts = opts or {}
    local results = {}

    local job = Job:new({
        command = 'git',
        args = { "lola" },
        on_stdout = function(_, line)
            table.insert(results, line)
        end,
        on_exit = vim.schedule_wrap(function()
            pickers.new(opts, {
                prompt_title = "Git Log",
                finder = finders.new_table {
                    results = results
                },
                sorter = conf.generic_sorter(opts),
                layout_strategy = 'vertical',   -- Display results in a vertical layout
                sorting_strategy = 'ascending', -- Show the newest results at the top
                layout_config = {
                    prompt_position = 'top',    -- Place the input prompt at the top
                },
            }):find()
        end),
    })
    job:start()
end

local delta_bcommits = previewers.new_termopen_previewer({
    get_command = function(entry)
        return {
            "git",
            "-c", "core.pager=delta",
            "-c", "delta.side-by-side=true",
            "diff",
            entry.value .. "^!",
            "--",
            entry.current_file,
        }
    end,
})

local delta = previewers.new_termopen_previewer({
    get_command = function(entry)
        return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value .. "^!" }
    end,
})


local delta_status = previewers.new_termopen_previewer({
    get_command = function(entry)
        -- Find the root of the Git repository
        local git_root_cmd = { "git", "rev-parse", "--show-toplevel" }
        local git_root_handle = io.popen(table.concat(git_root_cmd, " "))
        local git_root = git_root_handle:read("*all"):gsub("\n", "")
        git_root_handle:close()
        if entry.status.indexed then
            return { "bash", "-c", "cd " ..
            git_root .. " && git -c core.pager=delta -c delta.side-by-side=true diff --cached " .. entry.value }
        else
            return { "bash", "-c", "cd " ..
            git_root .. " && git -c core.pager=delta -c delta.side-by-side=true diff " .. entry.value }
        end
    end
})

Delta_git_commits = function(opts)
    opts = opts or {}
    opts.layout_config = {
        prompt_position = "top",
        preview_width = 0.75,
    }
    opts.previewer = {
        delta,
        previewers.git_commit_message.new(opts),
        previewers.git_commit_diff_as_was.new(opts),
    }
    builtin.git_commits(opts)
end

local custom_git_commit_message = previewers.new_termopen_previewer({
    get_command = function(entry)
        -- return { "git", "--no-pager", "lola", entry.value }
        return {
            "git",
            "show",
            "--no-patch",
            "--pretty=format:%C(green)%h%Creset %C(bold blue)%an%Creset %C(yellow)%ad%Creset%n%n%s%n%n%b",
            "--date=short",
            entry.value,
        }
    end,
})

Delta_git_bcommits = function(opts)
    opts = opts or {}
    opts.layout_config = {
        prompt_position = "top",
        preview_width = 0.60,
    }
    opts.previewer = {
        delta_bcommits,
        custom_git_commit_message,
        -- previewers.git_commit_message.new(opts),
        previewers.git_commit_diff_as_was.new(opts),
    }
    local status = pcall(builtin.git_bcommits, opts)
    if not status then
        print("no history to show")
    end
end

Delta_git_status = function(opts)
    opts = opts or {}
    opts.layout_config = {
        prompt_position = "top",
        preview_width = 0.75,
    }
    opts.sorting_strategy = "ascending"
    opts.previewer = delta_status
    builtin.git_status(opts)
end

local default_opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>lua Delta_git_commits()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>lua Delta_git_bcommits()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua Delta_git_status()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua Git_log_picker()<CR>", default_opts)

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<esc>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = false,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = false, -- use Ctrl-c to clear the prompt

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            theme = "dropdown",
            previewer = false,
            file_ignore_patterns = {
                "__pycache__",
                "node_modules",
                "%.pyc",
                "/.git",
                "middleware/target",
                "%.class"
            },
            --additional_args = function(opts)
            --return {"hidden=true"}
            --end
        },
        git_files = {
            theme = "dropdown",
            previewer = false,
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
        },
        live_grep = {
            layout_config = {
                prompt_position = "top",
                preview_width = 0.75,
            },
            sorting_strategy = "ascending",
            additional_args = function(_)
                return { "--hidden" }
            end
        },
    },
    extensions = {},
}

telescope.load_extension('dap')
