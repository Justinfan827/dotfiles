local lsp_utils = require("lsp.nvim_lsp")

require "lspconfig".cssls.setup {
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities
}
