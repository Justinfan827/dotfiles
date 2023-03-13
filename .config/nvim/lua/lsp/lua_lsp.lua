local lsp_utils = require("lsp.nvim_lsp")
--
-- LUA lsp server
--
require "lspconfig".lua_ls.setup {
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT"
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- disable an annoying pop up when lua lsp first initializes
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}
