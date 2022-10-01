--     tips on setting options
--     lua            command      global_value       local_value ~
--vim.o           :set                set                set
--vim.bo/vim.wo   :setlocal            -                 set
--vim.go          :setglobal          set                 -

-- Creating an autocommand in 0.7

-- auto go import
-- https://github.com/neovim/nvim-lspconfig/issues/115
vim.api.nvim_create_autocmd(
  "BufWritePre",
  {
    pattern = {"*.go"},
    callback = function()
      vim.lsp.buf.formatting_sync(nil, 3000)
    end
  }
)

vim.api.nvim_create_autocmd(
  "BufWritePre",
  {
    pattern = {"*.go"},
    callback = function()
      local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
      params.context = {only = {"source.organizeImports"}}

      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end
  }
)

vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "javascript,typescript,typescriptreact",
    callback = function()
      -- Number of spaces that a <Tab> in the file counts for.  Also see
      -- the |:retab| command, and the 'softtabstop' option.
      vim.opt_local.tabstop = 2
      -- Number of spaces that a <Tab> counts for while performing editing
      -- operations, like inserting a <Tab> or using <BS>.  It "feels" like
      -- <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is
      -- used.  This is useful to keep the 'ts' setting at its standard value
      -- of 8, while being able to edit like it is set to 'sts'.  However,
      -- commands like "x" still work on the actual characters.
      vim.opt_local.softtabstop = 2
      -- Number of spaces to use for each step of (auto)indent.  Used for
      -- |'cindent'|, |>>|, |<<|, etc.
      -- When zero the 'ts' value will be used.  Use the |shiftwidth()|
      -- function to get the effective shiftwidth value.
      vim.opt_local.shiftwidth = 2
      vim.opt.expandtab = true
    end,
    desc = "Set tabstop, softtabstop, shiftwidth for node development"
  }
)

vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({on_visual = true})
    end
  }
)

--auto format certain files (using formatter plugin)
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tf,*.lua FormatWrite
augroup END
]],
  true
)

local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command("augroup " .. group_name)
    api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      api.nvim_command(command)
    end
    api.nvim_command("augroup END")
  end
end
