-- Highlight the area that has been yanked
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "highlight_yank",
    callback = function() vim.highlight.on_yank() end,
})

-- remove whitespace
vim.api.nvim_create_augroup("remove_whitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "remove_whitespace",
    pattern = "*",
    command = [[:keepjumps keeppatterns %s/\s\+$//e]]
})


-- format terraform
vim.api.nvim_create_augroup("format_terraform", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function() vim.lsp.buf.format() end,
})


-- Rsync files that have .vim-arsync at the root of a git repo
-- Define a function to check if the current directory is a Git repository
local function execute_command(command)
    local file = io.popen(command)
    if not file then
        return ""
    end
    local output = file:read("*a")
    file:close()
    return output
end

local function is_git_repo(handle)
    local result = handle:read('*all')
    handle:close()
    return result ~= nil and result:match('^true')
end

local function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

-- Define the custom command to be executed on buffer save
local function run_arsync_up()
    local git_toplevel_cmd = "git rev-parse --show-toplevel"
    local git_folder = execute_command(git_toplevel_cmd)
    if not git_folder then
        return false
    end
    local vim_arsync_file = git_folder .. ".vim-arsync"
    if  file_exists(vim_arsync_file) then
        vim.cmd("ARsyncUp")
    end
end

-- Auto-execute the custom command on buffer save
vim.api.nvim_create_augroup("rsync_files", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback = run_arsync_up
})
