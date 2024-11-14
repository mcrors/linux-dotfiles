local home_dir = vim.fn.expand("~")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home_dir .. '/.cache/jdtls/workspace/' .. project_name

local config = {
    cmd = {
        home_dir .. '/.local/bin/jdtls',
        '-data', workspace_dir,
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
config.on_attach = require("user.lsp.handlers").on_attach
config.capabilities = require("user.lsp.handlers").capabilities
config.settings = {
    java = {
        format = {
            settings = {
                url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
                profile = 'GoogleStyle'
            }
        },
        imports = {
            gradle = {
                wrapper = {
                    checksums = {
                         { sha256 = '9a9afff59390e0cab2134d6113690dc6e25eb6b3b16b1288b441c4cbdfd97a09', allowed = true }
                    }
                }
            }
        }
    }
}

require('jdtls').start_or_attach(config)
