-- [[ Auto Commands ]]
-- Helper functions for creating autogroups and autocommands
local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- [[ Highlight on Yank ]]
-- Briefly highlight copied text
autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = augroup 'yank_highlight',
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Close Special Buffers with q ]]
-- Allow quick closing of special buffer types
autocmd('FileType', {
  desc = 'Close some filetypes with <q>',
  group = augroup 'close_with_q',
  pattern = {
    'OverseerForm',
    'OverseerList',
    'checkhealth',
    'git',
    'help',
    'lspinfo',
    'man',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'oil',
    'qf',
    'query',
    'dap-float',
    'dap-repl',
    'dbout',
  },
  callback = function(e)
    vim.bo[e.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = e.buf,
      silent = true,
      desc = 'Close buffer',
    })
  end,
})

-- [[ Auto Format Options ]]
-- Prevent automatic comment insertion on new lines
autocmd('BufWinEnter', {
  desc = 'Avoid auto insert comment on newline',
  group = augroup 'auto_format_options',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

-- [[ Go File Auto Import ]]
-- Automatically organize imports when saving Go files
autocmd('BufWritePre', {
  desc = 'Auto import and organize Go packages',
  group = augroup 'go_imports',
  pattern = '*.go',
  callback = function()
    -- Use modern LSP API to organize imports
    vim.lsp.buf.code_action {
      context = { only = { 'source.organizeImports' } },
      apply = true,
    }
  end,
})

-- [[ Language-specific Treesitter ]]
-- Enable treesitter highlighting for specific file types
autocmd('FileType', {
  desc = 'Enable treesitter highlighting for Go files',
  group = augroup 'treesitter_go',
  pattern = { 'go', 'gomod' },
  callback = function()
    vim.cmd 'TSBufEnable highlight'
  end,
})

autocmd('CmdlineEnter', {
  desc = 'enable hlsearch when entering cmdline',
  pattern = '/,?',
  group = augroup 'auto_hlsearch',
  command = 'set hlsearch',
})
autocmd('CmdlineLeave', {
  desc = 'disable hlsearch when leaving cmdline',
  pattern = '/,?',
  group = augroup 'auto_hlsearch',
  command = 'set nohlsearch',
})

autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { bg = 'NONE', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = 'NONE' })
  end,
})
