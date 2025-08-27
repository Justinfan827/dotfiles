require 'plugins.webdev'
require 'plugins.golang'

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Custom dev plugins
  require 'plugins.dev', -- custom dev plugins

  -- Complex plugins extracted to separate files
  require 'plugins.which-key',
  require 'plugins.telescope',

  -- LSP Plugins
  require 'plugins.lazydev',
  require 'plugins.lspconfig',

  -- Formatting and completion
  require 'plugins.conform',
  require 'plugins.blink-cmp',

  -- UI and utility plugins
  require 'plugins.todo-comments',
  require 'plugins.mini',
  require 'plugins.gruvbox-material',
  require 'plugins.treesitter',

  -- Additional plugins from init3.lua
  require 'plugins.render-markdown',
  require 'plugins.harpoon',
  require 'plugins.no-neck-pain',
  require 'plugins.noice',
  require 'plugins.fzf-vim',
  require 'plugins.trouble',
  require 'plugins.alpha-nvim',
  require 'plugins.barbecue',
  require 'plugins.oil',
  require 'plugins.treesj',
  require 'plugins.comment',
  require 'plugins.go',

  -- Simple plugins (inline)
  { -- mdx support
    'davidmh/mdx.nvim',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { -- custom status line
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opt = {
      enable_autocmd = false,
    },
  },
  'ruanyl/vim-gh-line', -- link to git repo
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  },
  'tpope/vim-fugitive', -- git wrapper in vim
  'christoomey/vim-tmux-navigator', -- help navigate with vim / tmux splits
  'nvim-treesitter/nvim-treesitter-textobjects', -- treesitter targeting of functions / paragraphs / classes
  require 'plugins.debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.autopairs',
  require 'plugins.neo-tree',
  require 'plugins.gitsigns', -- adds gitsigns recommend keymaps
}
