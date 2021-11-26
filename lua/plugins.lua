vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source ~/.config/nvim/init.vim | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- treesitter
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

-- Fzf for vim: fuzzy search (ESSENTIAL)
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'

  -- Helpers for unix
  use 'tpope/vim-eunuch'

  use 'tpope/vim-dispatch' -- dispatch async commands in vim (for git push and pull etc)
  use 'aacunningham/vim-fuzzy-stash' -- git stash from vim
  use 'tpope/vim-fugitive' -- git wrapper in vim
  use 'ruanyl/vim-gh-line' -- link to git repo
  use 'tpope/vim-unimpaired' -- nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
  use 'christoomey/vim-tmux-navigator' -- help navigate with vim / tmux splits
  use 'airblade/vim-rooter' -- Changes vim working directory to the project root (helpful for grepping tools)
  use 'AndrewRadev/splitjoin.vim' -- split structs in golang with gS, gJ
  use 'SirVer/ultisnips' --snippets
  use 'honza/vim-snippets' -- go snippets
  use 'qpkorr/vim-bufkill' -- kill buffer with :BD without killing session
  use 'tpope/vim-obsession'
  use 'vim-utils/vim-husk' -- navigate vim command line better 

  ---- Theme and styling
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use 'drewtempelmeyer/palenight.vim'
  use 'scrooloose/nerdcommenter' -- Key binding to comment out stuff

  -- Quoting/parenthesizing Note: i'm using coc pairs to run pair closing
  use 'tpope/vim-surround' -- amazing pugin to surround stuff
  use 'tpope/vim-repeat' -- Allow vim to repeat commands from vim-surround!
  use 'tpope/vim-endwise' -- This is a simple plugin that helps to end certain structures automatically. 
  use 'windwp/nvim-autopairs'


---- Modify * to also work with visual selections.
 use 'nelstrom/vim-visual-star-search'
---- Automatically clear search highlights after you move your cursor.
 use 'haya14busa/is.vim'

 -- fzf alternative
 use {'liuchengxu/vim-clap', run = ':Clap install-binary!'}

 -- nerd tree alternative
 use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
}

-- git signs
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  -- tag = 'release' -- To use the latest release
}

  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- language support
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  -- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'dag/vim-fish'

  --use {'neoclide/coc.nvim', branch = 'release'} -- CoC: Intellisense engine 
  --use 'fatih/vim-go'

  -- telescope test
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- test line
  use 'hoob3rt/lualine.nvim'

  -- lua scratchpad

end)
