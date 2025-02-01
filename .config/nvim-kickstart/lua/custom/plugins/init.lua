-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.wrap = false

vim.keymap.set('n', ';', ':', { desc = 'Remap : to ;' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { silent = true, desc = 'Save File' })
vim.keymap.set('n', '<CR>', 'G', { desc = 'Jump to line number with 123<CR>' })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move to the start of the line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Move to the end of the line' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('n', ',w', '<cmd>w<cr>', { desc = 'Write to buffer' })
vim.keymap.set('n', 'ss', ':split<Return><C-w>w', { desc = 'Horizontally split window' })
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { desc = 'Vertically split window' })
vim.keymap.set('n', '<leader>vv', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Change word under cursor' })

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
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'catppuccin-mocha'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'jellydn/hurl.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Optional, for markdown rendering with render-markdown.nvim
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown' },
        },
        ft = { 'markdown' },
      },
    },
    ft = 'hurl',
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = 'split',
      -- Default formatter
      formatters = {
        json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
        xml = {
          'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          '-xml',
          '-i',
          '-q',
        },
      },
      -- Default mappings for the response popup or split views
      mappings = {
        close = 'q', -- Close the response popup or split view
        next_panel = '<C-n>', -- Move to the next response popup window
        prev_panel = '<C-p>', -- Move to the previous response popup window
      },
    },
    keys = {
      -- Run API request
      { '<leader>A', '<cmd>HurlRunner<CR>', desc = 'Run All requests' },
      { '<leader>a', '<cmd>HurlRunnerAt<CR>', desc = 'Run Api request' },
      { '<leader>te', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Api request to entry' },
      { '<leader>tE', '<cmd>HurlRunnerToEnd<CR>', desc = 'Run Api request from current entry to end' },
      { '<leader>tm', '<cmd>HurlToggleMode<CR>', desc = 'Hurl Toggle Mode' },
      { '<leader>tv', '<cmd>HurlVerbose<CR>', desc = 'Run Api in verbose mode' },
      { '<leader>tV', '<cmd>HurlVeryVerbose<CR>', desc = 'Run Api in very verbose mode' },
      -- Run Hurl request in visual mode
      { '<leader>h', ':HurlRunner<CR>', desc = 'Hurl Runner', mode = 'v' },
    },
  },
}
