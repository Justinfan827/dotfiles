local augroup = function(name)
  vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'highlight on yank',
  callback = function()
    vim.hl.on_yank()
  end,
  group = augroup 'yank_highlight',
  pattern = '*',
})

autocmd('FileType', {
  desc = 'close some filetypes with <q>',
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
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = e.buf, silent = true, desc = 'Close buffer' })
  end,
})

--
autocmd('BufWinEnter', {
  desc = 'avoid auto insert comment on newline',
  group = augroup 'auto_format_options',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})
