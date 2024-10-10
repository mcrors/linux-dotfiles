local status_ok, config = pcall(require, "rest-nvim")
if not status_ok then
    return
end

config.setup({
    request = {
        skip_ssl_verification = true,
    },
    response = {
        hooks = {
            decode_url = true,
            format = true
        },
    },
    ui = {
        winbar = true,
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function(_)
        vim.bo.formatexpr = ""
        vim.bo.formatprg = "jq"
        print("It's a json file")
    end,
})
