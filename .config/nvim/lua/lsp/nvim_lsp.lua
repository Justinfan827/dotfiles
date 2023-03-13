--
-- export shared utilities for lsps
--

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--

local M = {}
local lsp_status = require("lsp-status")

--LSP status for lualine
lsp_status.register_progress()

local on_attach = function(client, bufnr)
  -- add lsp-status capabilities
  lsp_status.on_attach(client)
  -- Revisit this, i think we shouldn't enable omnifunc if we're using nvim cmp
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = {noremap = true, silent = true}
  -- open diagnostics in a float
  vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )

  -- Note: i also have the formatter plugin at the moment
  -- Format command to run lsp based formatting
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "ff",
      "<cmd>lua vim.lsp.buf.formatting()<CR>",
      {noremap = true, silent = false}
    )
  elseif client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "ff",
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
      {noremap = true, silent = false}
    )
  end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- use cmp_nvim_lsp + lsp-status capabilities
capabilities =
  vim.tbl_extend("keep", require("cmp_nvim_lsp").default_capabilities(capabilities), lsp_status.capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities
M.on_attach = on_attach

return M
