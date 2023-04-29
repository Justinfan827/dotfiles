local nvim_lsp = require "lspconfig"
--
-- eslint
--
nvim_lsp.eslint.setup {
   root_dir = nvim_lsp.util.root_pattern('package.json','tsconfig.json')
}
