local nvim_lsp = require "lspconfig"
local lsp_utils = require("lsp.nvim_lsp")

-- TODO: how do i setup pyright to per project settings?
nvim_lsp.pyright.setup {
  root_dir = nvim_lsp.util.root_pattern(".gitignore"), -- temp hack for lending fabfile. Add others
  cmd = {"pyright-langserver", "--stdio", "--project=~/.config/nvim/lua/lsp/pyrightconfig.txt"},
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities
}
