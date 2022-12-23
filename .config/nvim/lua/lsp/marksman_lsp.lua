local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")

if not configs.marksman then
  configs.marksman = {
    default_config = {
      cmd = {"marksman", "server"},
      single_file_support = true,
      root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
      filetypes = {"markdown"},
      init_options = {
        command = {}
      }
    }
  }
end

lspconfig.marksman.setup {}
