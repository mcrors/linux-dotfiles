local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/rhoulihan/.cache/jdtls/workspace/' .. project_name

local config = {
    cmd = {
        '/home/rhoulihan/.local/bin/jdtls',
        '-data', workspace_dir,
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
config.on_attach = require("user.lsp.handlers").on_attach
config.capabilities = require("user.lsp.handlers").capabilities
require('jdtls').start_or_attach(config)
