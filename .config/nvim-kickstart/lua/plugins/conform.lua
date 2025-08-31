return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = true,
    -- don't format using lsp
    format_on_save = function()
      local lsp_format_opt = 'never'
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true, sql = true }
    --   local lsp_format_opt
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     lsp_format_opt = 'never'
    --   else
    --     lsp_format_opt = 'fallback'
    --   end
    --   return {
    --     timeout_ms = 500,
    --     lsp_format = lsp_format_opt,
    --   }
    -- end,
    formatters_by_ft = {
      markdown = { 'prettierd' },
      lua = { 'stylua' },
      python = {
        'yapf',
      },
      -- javascript = { 'biome' },
      -- typescript = { 'biome' },
      -- typescriptreact = { 'biome' },
      -- javascriptreact = { 'biome' },
      -- json = { 'biome' },
      -- jsonc = { 'biome' },
      -- css = { 'biome' },
      -- yaml = { 'prettierd' },
      go = { 'gopls' },
      sql = { 'pg_format' },
      terraform = { 'terraform_fmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
