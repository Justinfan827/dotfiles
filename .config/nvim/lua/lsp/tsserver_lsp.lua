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

    -- dont use lsp ts utils for now
    --local ts_utils = require("nvim-lsp-ts-utils")

    ---- set up nvim-lsp-ts-utils with some sensible defaults.
    ---- Feel free to check out the project’s repository if you want to set up additional features,
    ---- but for now, we’ll get some useful commands, diagnostics and code actions from ESLint,
    ---- and formatting from Prettier.

    --ts_utils.setup(
    --{
    ---- eslint_d, a faster version of eslint that provides a much better experience
    --eslint_bin = "eslint_d",
    --eslint_enable_diagnostics = true,
    --eslint_enable_code_actions = true,
    --enable_formatting = true,
    --formatter = "prettier",
    --format_on_save = true
    --}
    --)
    --ts_utils.setup_client(client)
    --buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    --buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    --buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
  end,
  capabilities = lsp_utils.capabilities,
  flags = {
    debounce_text_changes = 150
  }
}
