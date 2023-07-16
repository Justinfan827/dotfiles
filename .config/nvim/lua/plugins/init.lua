--https://github.com/folke/lazy.nvim#-structuring-your-plugins
return {
  -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
  "folke/neodev.nvim",
  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "github/copilot.vim",
  "mbbill/undotree", -- undo tree is amazing
  "lukas-reineke/indent-blankline.nvim",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag", -- auto tag for closing react tags
  "windwp/nvim-autopairs", -- auto pairs
  "junegunn/fzf.vim",
  -- I might need this below
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end
  },
  -- Helpers for unix
  "tpope/vim-eunuch",
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function(LazyPlugin)
      require("trouble").setup {} -- do i need this?
    end
  },
  -- git helpers
  "tpope/vim-dispatch", -- dispatch async commands in vim (for git push and pull etc)
  "aacunningham/vim-fuzzy-stash", -- git stash from vim
  "tpope/vim-fugitive", -- git wrapper in vim
  {
    -- nvim entry screen
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function(LazyPlugin)
      require "alpha".setup(require "alpha.themes.startify".config)
    end
  },
  "ruanyl/vim-gh-line", -- link to git repo
  "ThePrimeagen/git-worktree.nvim",
  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
    -- tag = 'release' -- To use the latest release
  },
  "tpope/vim-unimpaired", -- nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
  "stsewd/gx-extended.vim", -- make gx work in opening files
  "christoomey/vim-tmux-navigator", -- help navigate with vim / tmux splits
  -- misc helpers
  -- New NVIM rooter: this is problematic for new installs
  {
    "ahmedkhalf/project.nvim",
    config = function(LazyPlugin)
      require("tools.lsp_rooter").setup()
    end
  },
  "AndrewRadev/splitjoin.vim", -- split structs in golang with gS, gJ
  {"L3MON4D3/LuaSnip", tag = "v1.0.0"},
  "honza/vim-snippets", -- go snippets
  "qpkorr/vim-bufkill", -- kill buffer with :BD without killing session
  "vim-utils/vim-husk", -- navigate vim command line better
  ---- Theme and styling
  "kaicataldo/material.vim",
  -- Load gruvbox without lazy since it's my default colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end
  },
  "navarasu/onedark.nvim",
  "drewtempelmeyer/palenight.vim",
  "norcalli/nvim-colorizer.lua",
  "scrooloose/nerdcommenter", -- Key binding to comment out stuff
  -- surround stuff
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  "tpope/vim-repeat", -- Allow vim to repeat commands from vim-surround!
  "tpope/vim-endwise", -- This is a simple plugin that helps to end certain structures automatically.
  ---- Modify * to also work with visual selections.
  "nelstrom/vim-visual-star-search",
  ---- Automatically clear search highlights after you move your cursor.
  "haya14busa/is.vim",
  -- nerd tree alternative
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("tools.nvim_tree").setup {}
    end
  },
  -- language support
  "onsails/lspkind.nvim", -- vscode-like pictograms to neovim built in lsp
  "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
  "nvim-lua/lsp-status.nvim", -- helper for getting status of lsp onto lualine
  "MunifTanjim/prettier.nvim", -- prettier support
  "jose-elias-alvarez/null-ls.nvim", -- null-ls is a language server abstraction
  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "rafamadriz/friendly-snippets", -- friendly snippets for a whole bunch of languages
  -- telescope
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim"
    -- dependencies = {{"nvim-lua/plenary.nvim"}}
  },
  "nvim-telescope/telescope-fzy-native.nvim",
  {
    "benfowler/telescope-luasnip.nvim"
  },
  -- lua line
  "hoob3rt/lualine.nvim",
  -- testing formatting
  "mhartington/formatter.nvim",
  -- persistent marks
  "ThePrimeagen/harpoon",
  -- floating terminal
  "voldikss/vim-floaterm",
  -- whichkey for better leader key
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
  -- substitutions
  "svermeulen/vim-subversive",
  -- zen /focus mode
  "Pocco81/TrueZen.nvim",
  -- buffer line
  {"akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons"},
  --search and replace
  "windwp/nvim-spectre",
  -- go test file switch
  -- "benmills/vim-golang-alternate" -- PR's in nvim omg
  -- {
  --"pwntester/octo.nvim",
  --dependencies = {
  --"nvim-lua/plenary.nvim",
  --"nvim-telescope/telescope.nvim",
  "nvim-tree/nvim-web-devicons",
  --},
  --config = function()
  --require("tools.octo").octoSetup()
  --end
  --}

  -- Debugging
  "mfussenegger/nvim-dap",
  {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  "leoluz/nvim-dap-go",
  -- folding
  -- {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"}
  -- easy motion
  {
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require "hop".setup {keys = "asdfjkl;"}
    end
  }
  -- personal plugins
  -- "~/workbench/testy/testy.nvim"
}
