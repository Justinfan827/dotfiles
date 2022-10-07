local nvim_lsp = require "lspconfig"
local lsp_utils = require("lsp.nvim_lsp")

-- https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/

--
-- LUA server
-- remember to add: export PATH="$HOME/tools/lua-language-server/bin/macOS:$PATH"
--
local sumneko_root_path = vim.fn.getenv "HOME" .. "/tools/lua-language-server" -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = lsp_utils.on_attach,
  capabilities = lsp_utils.capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}
