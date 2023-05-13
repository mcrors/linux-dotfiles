local dap = require('dap')
dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/kitty';
}
dap.defaults.fallback.force_external_terminal = true

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
