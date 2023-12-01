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
  group = "format_terraform",
  pattern = {"*.tf", "*.tfvars"},
  callback = function() vim.lsp.buf.format() end,
})


-- OLD WAY TO FORMAT GO, MAY USE IT AGAIN IN THE FUTURE
-- format go using goformat
-- local function go_format()
  -- local current_file = vim.fn.expand('%:p') -- Get the full path of the current file
  -- local command = string.format('goformat -w %s', current_file)
  -- local job_id = vim.fn.jobstart(command, {
    -- on_exit = function(_, code)
      -- if code == 0 then
        -- vim.cmd('edit') -- Reload the buffer to reflect the changes
      -- end
    -- end
  -- })
  -- vim.fn.jobwait({ job_id }, -1) -- Wait for the job to finish
-- end

-- vim.api.nvim_create_augroup("format_go", { clear = true })
-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
    -- group = "format_go",
    -- pattern = {"*.go"},
    -- callback = go_format
-- })


local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- 2 space tabs for YAML files
vim.api.nvim_create_augroup("yaml_tab_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    group = "yaml_tab_settings",
    command = "setlocal ts=2 sts=2 sw=2 expandtab"
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
    return string.gsub(output, "\n", "/")
end

local function file_exists(name)
   local f = io.open(name, "r")
   if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

-- Define the custom command to be executed on buffer save
local function run_arsync_up()
    local git_toplevel_cmd = "git rev-parse --show-toplevel 2>/dev/null"
    local git_folder = execute_command(git_toplevel_cmd)
    if not git_folder then
        return false
    end
    local vim_arsync_file = string.format("%s.vim-arsync", git_folder)
    if file_exists(vim_arsync_file) then
        print("Syncing")
        vim.cmd("ARsyncUp")
    end
end

-- Auto-execute the custom command on buffer save
vim.api.nvim_create_augroup("rsync_files", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    group = "rsync_files",
    pattern = "*",
    callback = run_arsync_up
})


