local treesitter_status_ok, _ = pcall(require, "treesitter")
if not treesitter_status_ok then
  return
end

local configs = require("nvim-treesitter.configs")
configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "yaml" } },
}
