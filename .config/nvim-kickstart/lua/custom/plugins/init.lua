-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.wrap = false

-- Avoid typing :
vim.keymap.set('n', ';', ':', { desc = 'Remap : to ;' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { silent = true, desc = 'Save File' })
vim.keymap.set('n', '<CR>', 'G', { desc = 'Jump to line number with 123<CR>' })
vim.keymap.set('n', 'H', '^', { desc = 'Move to the start of the line' })
vim.keymap.set('n', 'L', '$', { desc = 'Move to the end of the line' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('n', ',w', '<cmd>w<cr>', { desc = 'Write to buffer' })

--
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
-- set spacing / indents for go projects
--
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    -- Insert mode: Add fmt.Println() and place cursor inside parentheses
    vim.keymap.set('i', 'fpp', 'fmt.Println()<Esc>==f(a', { desc = 'Insert fmt.Println() with cursor inside parentheses' })

    -- Insert mode: Add fmt.Println("") and place cursor inside quotes
    vim.keymap.set('i', 'fpq', 'fmt.Println("")<Esc>==f"a', { desc = 'Insert fmt.Println("") with cursor inside quotes' })

    -- Visual mode: Console log selection on next line, placing selection inside parentheses
    vim.keymap.set('v', 'fpp', 'yofpp<Esc>p', { desc = 'Console log visual selection on next line' })

    -- Normal mode: Console log on next line with "LOGGING" and word under cursor
    vim.keymap.set('n', 'fpp', '"ayiwofmt.Println("LOGGING", <C-R>a)<Esc>', { desc = 'Console log word under cursor on next line' })

    -- Insert mode: Add fmt.Printf("\\n\\n\\n") and place cursor inside parentheses
    vim.keymap.set('i', 'fpn', 'fmt.Printf("\\n\\n\\n")<Esc>==f(a', { desc = 'Insert fmt.Printf("\\n\\n\\n") with cursor inside parentheses' })
  end,
  desc = 'Set tabstop, softtabstop, shiftwidth for go development',
})

return {
  'christoomey/vim-tmux-navigator', -- help navigate with vim / tmux splits
  -- start screen
  {
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require 'alpha.themes.startify'
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = 'devicons'
      require('alpha').setup(startify.config)
    end,
  },
  -- colorscheme for transparent background
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, opts = {} },
}
