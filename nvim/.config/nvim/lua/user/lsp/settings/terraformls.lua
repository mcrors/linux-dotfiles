local util = require "lspconfig/util"
return {
  default_config = {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_dir = util.root_pattern('.terraform', '.git'),
  },
}
