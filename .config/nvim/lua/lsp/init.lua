require("lsp.gopls_lsp")
require('lsp.signature')
--require("lsp.nvim_lsp")
--require("lsp.bashls_lsp")
--require("lsp.eslint_lsp")
--require("lsp.jsonls_lsp")
--require("lsp.lua_lsp")
--require("lsp.pyright_lsp")
--require("lsp.tsserver_lsp")
--require("lsp.yamlls_lsp")
--require("lsp.sqlls_lsp")
--require("lsp.marksman_lsp")
--require("lsp.null_ls")
--require("lsp.css")
--require("lsp.emmet")
--require("lsp.html")

-- comment out the above and uncomment the below to try out mason.
-- trying out mason.

local mason = require("mason")
local lspconfig = require("lspconfig")
local masonLspConfig = require("mason-lspconfig")
local cmpNvimLsp = require("cmp_nvim_lsp")

mason.setup(
  {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  }
)

masonLspConfig.setup(
  {
    ensure_installed = {
      "lua_ls",
      "jsonls",
      "tsserver",
      "eslint",
      "prismals",
      "gopls",
      "tailwindcss",
      "html",
      "cssls",
      "astro",
      "yamlls",
      "taplo",
      "marksman",
      "dockerls",
      "cssmodules_ls",
      "emmet_language_server"
    }
  }
)

local opts = {
  capabilities = cmpNvimLsp.default_capabilities(),
  on_attach = require("lsp.on_attach").on_attach
}

-- :h mason-lspconfig.setup_handlers()
masonLspConfig.setup_handlers(
  {
    -- default setup function
    function(server_name)
      -- setup custom server configs
      local has_custom_opts, custom_opts = pcall(require, "config.lsp.settings." .. server_name)
      local server_opts = opts
      if has_custom_opts then
        server_opts = vim.tbl_deep_extend("force", custom_opts, opts)
      end
      lspconfig[server_name].setup(server_opts)
    end,
    ["tsserver"] = function()
      local ts = require("typescript")
      ts.setup(
        {
          server = opts
        }
      )
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup(
        {
          on_attach = opts.on_attach,
          capabilities = opts.capabilities,
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
      )
    end,
    --
    -- gopls: https://www.getman.io/posts/programming-go-in-neovim/
    --
    ["gopls"] = function()
      lspconfig.gopls.setup(
        {
          capabilities = opts.capabilities,
          on_attach = opts.on_attach,
          flags = {
            debounce_text_changes = 150
          },
          --root_dir = nvim_lsp.util.root_pattern("main.go", "go.mod"),
          filetypes = {"go", "gomod"},
          cmd = {"gopls", "serve"},
          settings = {
            gopls = {
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
      )
    end
  }
)

-- setup nullls with mason
require("lsp.null_ls")
