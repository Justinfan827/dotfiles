require 'plugins.webdev'
require 'plugins.golang'

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'rafamadriz/friendly-snippets' },
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
}
