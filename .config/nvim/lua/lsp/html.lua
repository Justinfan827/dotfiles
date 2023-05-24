local lsp_utils = require("lsp.nvim_lsp")
require "lspconfig".html.setup {
  capabilities = lsp_utils.capabilities
}
