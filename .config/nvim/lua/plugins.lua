vim.cmd(
  [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source ~/.config/nvim/init.vim | PackerCompile
  augroup end
]]
)

return require("packer").startup(
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    -- https://alpha2phi.medium.com/neovim-for-beginners-code-folding-7574925412ea
    -- better folding
    --use {
    --"kevinhwang91/nvim-ufo",
    --opt = true,
    --event = {"BufReadPre"},
    --wants = {"promise-async"},
    --requires = "kevinhwang91/promise-async",
    --config = function()
    --require("ufo").setup {
    --provider_selector = function(bufnr, filetype)
    --return {"lsp", "treesitter", "indent"}
    --end
    --}
    --vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    --vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    --end
    --}

    -- Fzf for vim: fuzzy search (ESSENTIAL)
    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end
    }
    use "junegunn/fzf.vim"

    -- Helpers for unix
    use "tpope/vim-eunuch"

    -- git helpers
    use "tpope/vim-dispatch" -- dispatch async commands in vim (for git push and pull etc)
    use "aacunningham/vim-fuzzy-stash" -- git stash from vim
    use "tpope/vim-fugitive" -- git wrapper in vim
    use "ruanyl/vim-gh-line" -- link to git repo
    use "ThePrimeagen/git-worktree.nvim"
    -- git signs
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
      -- tag = 'release' -- To use the latest release
    }

    -- misc helpers
    use "tpope/vim-unimpaired" -- nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
    use "stsewd/gx-extended.vim" -- make gx work in opening files
    use "christoomey/vim-tmux-navigator" -- help navigate with vim / tmux splits
    --use "airblade/vim-rooter" -- Changes vim working directory to the project root (helpful for grepping tools)
    -- New NVIM rooter
    use {
      "ahmedkhalf/project.nvim",
      config = require("tools.lsp_rooter").setup()
    }
    use "AndrewRadev/splitjoin.vim" -- split structs in golang with gS, gJ
    --use "SirVer/ultisnips" --snippets
    use "L3MON4D3/LuaSnip" -- Snippets plugin
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "honza/vim-snippets" -- go snippets
    use "qpkorr/vim-bufkill" -- kill buffer with :BD without killing session
    use "vim-utils/vim-husk" -- navigate vim command line better
    use {
      -- session management
      -- Auto Session by default stores sessions in vim.fn.stdpath('data').."/sessions/".
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup {
          log_level = "info",
          auto_session_suppress_dirs = {"~/"}
        }
      end
    }

    ---- Theme and styling
    --
    use "kaicataldo/material.vim"
    use {"ellisonleao/gruvbox.nvim"}
    use(
      {
        "catppuccin/nvim",
        as = "catppuccin"
      }
    )
    use "navarasu/onedark.nvim"

    --use 'eddyekofo94/gruvbox-flat.nvim'
    use "drewtempelmeyer/palenight.vim"
    use "scrooloose/nerdcommenter" -- Key binding to comment out stuff

    -- Quoting/parenthesizing Note: i'm using coc pairs to run pair closing
    use "tpope/vim-surround" -- amazing pugin to surround stuff
    use "tpope/vim-repeat" -- Allow vim to repeat commands from vim-surround!
    use "tpope/vim-endwise" -- This is a simple plugin that helps to end certain structures automatically.
    use "windwp/nvim-autopairs"

    ---- Modify * to also work with visual selections.
    use "nelstrom/vim-visual-star-search"
    ---- Automatically clear search highlights after you move your cursor.
    use "haya14busa/is.vim"

    -- fzf alternative
    use {"liuchengxu/vim-clap", run = ":Clap install-binary!"}

    -- nerd tree alternative
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = require("tools.nvim_tree").setup()
    }

    -- language support
    use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
    use "nvim-lua/lsp-status.nvim" -- helper for getting status of lsp onto lualine
    use "jose-elias-alvarez/nvim-lsp-ts-utils" -- typescript helper
    -- Completion
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"

    use "dag/vim-fish"

    --use {'neoclide/coc.nvim', branch = 'release'} -- CoC: Intellisense engine
    --use 'fatih/vim-go'

    -- telescope
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/plenary.nvim"}}
    }
    use "nvim-telescope/telescope-fzy-native.nvim"
    -- lua line
    use "hoob3rt/lualine.nvim"

    -- testing formatting
    use "mhartington/formatter.nvim"

    -- persistent marks
    use "ThePrimeagen/harpoon"

    -- floating terminal
    use "voldikss/vim-floaterm"
    -- whichkey for better leader key
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    }
    -- substitutions
    use "svermeulen/vim-subversive"

    -- zen /focus mode
    use "Pocco81/TrueZen.nvim"

    -- buffer line
    use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"}

    -- search and replace
    use "windwp/nvim-spectre"

    -- go test file switch
    use "benmills/vim-golang-alternate"

    -- PR's in nvim omg
    --use {
    --"pwntester/octo.nvim",
    --requires = {
    --"nvim-lua/plenary.nvim",
    --"nvim-telescope/telescope.nvim",
    --"kyazdani42/nvim-web-devicons"
    --},
    --config = function()
    --require("tools.octo").octoSetup()
    --end
    --}

    -- easy motion
    use {
      "phaazon/hop.nvim",
      branch = "v1", -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require "hop".setup {keys = "asdfjkl;"}
      end
    }
    -- personal plugins
    --use "~/workbench/testy/testy.nvim"

    -- lua scratchpad
  end
)
