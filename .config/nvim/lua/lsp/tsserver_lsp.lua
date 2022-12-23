local nvim_lsp = require "lspconfig"
local lsp_utils = require("lsp.nvim_lsp")
--
-- tsserver
--
--

-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    lsp_utils.on_attach(client, bufnr)
  end,
  capabilities = lsp_utils.capabilities,
  flags = {
    debounce_text_changes = 150
  }
}
