local lsp = require('lsp.nvim_lsp')
local nvim_lsp = require('lspconfig')

local on_attach = lsp.on_attach
local capabilities  = lsp.capabilities

-- tsserver
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}
