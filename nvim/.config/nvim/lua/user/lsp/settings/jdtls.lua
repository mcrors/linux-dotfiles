local util = require 'lspconfig/util'

return {
  cmd = {
        'jdtls',
    },
  filetypes = {'java'},
  root_dir = function(fname)
    return util.root_pattern('pom.xml', 'build.gradle', '.git')(fname) or vim.fn.getcwd()
  end,
  settings = {
    java = {
      format = {
        settings = {
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          profile = 'GoogleStyle'
        }
      }
    },
    jdt = {
        ls = {
            lombok = {
                enabled = false
            }
        }
    }
  },
  init_options = {
    bundles = {}
  }
}
