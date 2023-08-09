--https://github.com/folke/lazy.nvim#-structuring-your-plugins
return {
  --- essentials
  "nvim-treesitter/nvim-treesitter", -- treesitter support
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "MunifTanjim/nui.nvim",
  ---
  --- Editing
  ---
  "mbbill/undotree", -- undo tree is amazing
  -- "zbirenbaum/copilot.lua", -- github copilot
  "github/copilot.vim",
  "lukas-reineke/indent-blankline.nvim",
  "windwp/nvim-ts-autotag", -- auto tag for closing react tags
  "windwp/nvim-autopairs", -- auto pairs
  "tpope/vim-eunuch", -- Helpers for unix
  "junegunn/fzf.vim", -- fzf
  "tpope/vim-unimpaired", -- mappings for quickfix + location lists
  {
    -- Fzf for vim: fuzzy search (ESSENTIAL)
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end
  },
  "svermeulen/vim-subversive", -- substitutions
  "Pocco81/TrueZen.nvim", -- zen /focus mode
  "windwp/nvim-spectre", --search and replace
  "tpope/vim-repeat", -- Allow vim to repeat commands from vim-surround!
  "tpope/vim-endwise", -- This is a simple plugin that helps to end certain structures automatically.
  "nelstrom/vim-visual-star-search", ---- Modify * to also work with visual selections.
  "haya14busa/is.vim", ---- Automatically clear search highlights after you move your cursor.
  --
  -- tools
  --
  "tpope/vim-dispatch", -- dispatch async commands in vim (for git push and pull etc)
  "aacunningham/vim-fuzzy-stash", -- git stash from vim
  "tpope/vim-fugitive", -- git wrapper in vim
  "ThePrimeagen/git-worktree.nvim",
  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  -- "tpope/vim-unimpaired", -- nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
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
  "qpkorr/vim-bufkill", -- kill buffer with :BD without killing session
  "vim-utils/vim-husk", -- navigate vim command line better
  ---- Theme and styling
  "kaicataldo/material.vim",
  -- Load gruvbox without lazy since it's my default colorscheme
  {
    "luisiacc/gruvbox-baby"
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("onedark").setup(
  --       {
  --         style = "warm"
  --       }
  --     )
  --     require("onedark").load()
  --     vim.cmd([[colorscheme onedark]])
  --   end
  -- },
  "ruanyl/vim-gh-line", -- link to git repo
  "navarasu/onedark.nvim",
  "drewtempelmeyer/palenight.vim",
  "brenoprata10/nvim-highlight-colors", -- colors for tailwind and stuff
  --"norcalli/nvim-colorizer.lua",
  "max397574/better-escape.nvim", -- a better escape
  "ethanholz/nvim-lastplace", -- intelligently reopen files at your last edit position
  "JoosepAlviste/nvim-ts-context-commentstring", -- comment string based on context
  "numToStr/Comment.nvim", -- commenter
  -- "abecodes/tabout.nvim", -- tab out of brackets, parens, etc (might be interferring with copilot)
  -- surround stuff
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  -- nerd tree alternative
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("tools.nvim_tree").setup()
    end
  },
  --
  -- LSP language support
  --
  --
  --
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu"
  },
  "ray-x/lsp_signature.nvim", -- show signatures while typing
  {"j-hui/fidget.nvim", tag = "legacy"}, -- show status for lsp in pop up
  "kosayoda/nvim-lightbulb", -- lightbulb for codeactions
  "MunifTanjim/prettier.nvim", -- prettier support
  "jayp0521/mason-null-ls.nvim", -- mason null-ls integration
  "jose-elias-alvarez/null-ls.nvim", -- null-ls is a language server abstraction
  "smjonas/inc-rename.nvim",
  "jose-elias-alvarez/typescript.nvim", -- typescript language server
  "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
  "nvim-lua/lsp-status.nvim", -- helper for getting status of lsp onto lualine
  "williamboman/mason-lspconfig.nvim", -- manage lsp installations
  "williamboman/mason.nvim", -- manage lsp installations
  {
    "folke/trouble.nvim", -- nice error list
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function(LazyPlugin)
      require("trouble").setup({})
    end
  },
  {
    "utilyre/barbecue.nvim", -- winbar like vscode
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons" -- optional dependency
    },
    opts = {}
  },
  --
  -- cmp
  --
  "onsails/lspkind.nvim", -- vscode-like pictograms to neovim built in lsp
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  -- "zbirenbaum/copilot-cmp",
  "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "rafamadriz/friendly-snippets", -- friendly snippets for a whole bunch of languages
  {"L3MON4D3/LuaSnip", tag = "v1.0.0"},
  "honza/vim-snippets", -- go snippets
  --
  -- telescope
  --
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  "benfowler/telescope-luasnip.nvim",
  "mhartington/formatter.nvim", -- formatter
  "ThePrimeagen/harpoon", -- persistent marks
  "voldikss/vim-floaterm", -- floating terminal
  "folke/which-key.nvim", -- whichkey for better leader key
  --
  -- UI improvements
  --
  "stevearc/dressing.nvim",
  "hoob3rt/lualine.nvim", -- lua line
  "nvim-tree/nvim-web-devicons",
  {"akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons"}, -- buffer line
  {
    -- nvim entry screen
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function(LazyPlugin)
      require("alpha").setup(require("alpha.themes.startify").config)
    end
  },
  ---
  --- Debugging
  ---
  "mfussenegger/nvim-dap",
  {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}},
  "leoluz/nvim-dap-go",
  -- folding
  -- {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"}
  -- personal plugins
  -- "~/workbench/testy/testy.nvim"
  --
  -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
  "folke/neodev.nvim"
}
