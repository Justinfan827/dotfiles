return {
  'junegunn/fzf.vim', -- fzf
  config = function()
    vim.keymap.set('n', ',/', '<cmd>Ag!<CR>', { desc = 'live grep' })
    vim.keymap.set('n', ',ag', '<cmd>Ag! <C-R><C-W><CR>', { silent = true, desc = 'Search for word under cursor' })
  end,
}