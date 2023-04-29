local nvim_lsp = require "lspconfig"
--
-- yaml
--
nvim_lsp.yamlls.setup {
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
}
