local lsp_utils = require("lsp.nvim_lsp")
require "lspconfig".cssls.setup {
  capabilities = lsp_utils.capabilities
}
