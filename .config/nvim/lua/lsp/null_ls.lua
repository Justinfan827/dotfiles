local null_ls = require("null-ls")
local prettier = require("prettier")
prettier.setup {
  bin = "prettierd",
  filetypes = {
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  }
}
-- register any number of sources simultaneously
--null_ls.builtins.formatting.prettierd
local sources = {}

null_ls.setup({sources = sources})
