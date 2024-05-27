local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {
        "bash",
        "cmake",
        "cpp",
        "c_sharp",
        "dockerfile",
        "go",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "lua",
        "make",
        "ninja",
        "proto",
        "python",
        "terraform",
        "yaml",
        "bash",
        "xml",
    }, -- one of "all" or a list of languages
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "css" } },
})

