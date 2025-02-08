-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.wrap = false
-- auto-session requirement for highlighting
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
-- open repo in browser
vim.g.gh_line_map = '<leader>bg'
-- fzf history
vim.g.fzf_history_dir = '~/.local/share/fzf-history'

-- require my custom mappings
require 'custom.mappings'

return {
  -- typescript plugins
  require 'custom.plugins.webdev',
  require 'custom.plugins.golang',
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
  },
  'ruanyl/vim-gh-line', -- link to git repo
  {
    'junegunn/fzf.vim', -- fzf
    config = function()
      vim.keymap.set('n', ',/', ':Ag!<CR>', { desc = 'live grep' })
      vim.keymap.set('n', ',ag', ':Ag! <C-R><C-W><CR>', { silent = true, desc = 'Search for word under cursor' })
    end,
  },
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  },
  'tpope/vim-fugitive', -- git wrapper in vim
  {
    'folke/trouble.nvim',
    -- for default options, refer to the configuration section for custom setup.
    opts = {
      follow = false,
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  -- help navigate with vim / tmux splits
  'christoomey/vim-tmux-navigator',
  -- treesitter targeting of functions / paragraphs / classes
  'nvim-treesitter/nvim-treesitter-textobjects',
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
  {
    'utilyre/barbecue.nvim', -- winbar like vscode
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {},
  },
  -- oil is a file tree navigator
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'github/copilot.vim',
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>ls', '<cmd>SessionSearch<CR>', desc = 'Session search' },
      { '<leader>ll', '<cmd>SessionSave<CR>', desc = 'Save session' },
      -- { '<leader>la', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup {--[[ your config ]]
      }
    end,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 2
      -- vim.cmd.colorscheme 'gruvbox-material'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
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
}
