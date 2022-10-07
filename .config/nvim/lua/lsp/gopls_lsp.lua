local nvim_lsp = require "lspconfig"
local lsp_utils = require("lsp.nvim_lsp")

-- import on save taken from: https://cs.opensource.google/go/x/tools/+/refs/tags/gopls/v0.8.1:gopls/doc/vim.md
-- global function
function GO_IMPORTS(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

--
-- gopls: https://www.getman.io/posts/programming-go-in-neovim/
--
nvim_lsp.gopls.setup {
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities,
  flags = {
    debounce_text_changes = 150
  },
  filetypes = {"go", "gomod"},
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      --env = {
      --GO_ROOT = "/Users/justin/sdk/go1.18beta1",
      --GO_ROOT = "/usr/local/opt/go/libexec",
      --PATH = "$HOME/golang/bin/go1.18beta1:$PATH"
      --},
      analyses = {
        unusedparams = true
      },
      staticcheck = true,
      buildFlags = {
        "-tags=integration"
      }
    }
  }
}
