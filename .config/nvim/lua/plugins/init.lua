--https://github.com/folke/lazy.nvim#-structuring-your-plugins
return {
	--- essentials
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"MunifTanjim/nui.nvim",
	---
	--- Editing
	---
	"mbbill/undotree", -- undo tree is amazing
	"ThePrimeagen/git-worktree.nvim",
	-- "zbirenbaum/copilot.lua", -- github copilot
	"github/copilot.vim",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"windwp/nvim-ts-autotag", -- auto tag for closing react tags
	"windwp/nvim-autopairs", -- auto pairs
	"tpope/vim-eunuch", -- Helpers for unix
	"junegunn/fzf.vim", -- fzf
	{
		"rcarriga/nvim-notify", -- i hate this
		config = function()
			-- local notify = require("notify")
			-- notify.setup({
			-- 	background_colour = "#000000",
			-- })
			-- vim.notify = notify
		end,
	}, -- notifications
	"tpope/vim-unimpaired", -- mappings for quickfix + location lists
	{
		"AckslD/nvim-neoclip.lua",
		run = function()
			require("neoclip").setup()
		end,
	},
	{
		-- Fzf for vim: fuzzy search (ESSENTIAL)
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	},
	"svermeulen/vim-subversive", -- substitutions
	{
		"folke/zen-mode.nvim",
		opts = {},
	},
	{
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup({
				replace_engine = {
					["sed"] = {
						cmd = "sed",
						args = {
							"-i",
							"",
							"-E",
						},
					},
				},
			})
		end,
	}, --search and replace
	"tpope/vim-repeat", -- Allow vim to repeat commands from vim-surround!
	"tpope/vim-endwise", -- This is a simple plugin that helps to end certain structures automatically.
	"nelstrom/vim-visual-star-search", ---- Modify * to also work with visual selections.
	"haya14busa/is.vim", ---- Automatically clear search highlights after you move your cursor.
	--
	-- tools
	--
	{ -- testing inside neovim
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup({
				-- your neotest config here
				adapters = {
					require("neotest-go"),
				},
			})
		end,
	},

	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{

		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	"tpope/vim-dispatch", -- dispatch async commands in vim (for git push and pull etc)
	"aacunningham/vim-fuzzy-stash", -- git stash from vim
	"tpope/vim-fugitive", -- git wrapper in vim
	"ThePrimeagen/git-worktree.nvim",
	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- "tpope/vim-unimpaired", -- nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
	"stsewd/gx-extended.vim", -- make gx work in opening files
	"christoomey/vim-tmux-navigator", -- help navigate with vim / tmux splits
	-- misc helpers
	-- New NVIM rooter: this is problematic for new installs
	{
		"ahmedkhalf/project.nvim",
	},
	"Wansmer/treesj",
	keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require("treesj").setup({--[[ your config ]]
			use_default_keymaps = false,
		})
	end,
	"qpkorr/vim-bufkill", -- kill buffer with :BD without killing session
	"vim-utils/vim-husk", -- navigate vim command line better
	---- Theme and styling
	"kaicataldo/material.vim",
	-- Load gruvbox without lazy since it's my default colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_transparent_background = 2
			vim.cmd([[
				colorscheme gruvbox-material
				]])
		end,
	},
	"ruanyl/vim-gh-line", -- link to git repo
	"ruifm/gitlinker.nvim", -- link to git repo
	-- "brenoprata10/nvim-highlight-colors", -- colors for tailwind and stuff
	--"norcalli/nvim-colorizer.lua",
	{ -- better escape
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				k = function()
					vim.api.nvim_input("<esc>")
					local current_line = vim.api.nvim_get_current_line()
					if current_line:match("^%s+j$") then
						vim.schedule(function()
							vim.api.nvim_set_current_line("")
						end)
					end
				end,
			})
		end,
	},
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
		end,
	},
	--
	-- LSP language support
	--
	--
	--
	-- {
	-- 	-- deprecated
	-- 	"weilbith/nvim-code-action-menu",
	-- 	cmd = "CodeActionMenu",
	-- },
	"ray-x/lsp_signature.nvim", -- show signatures while typing
	{ "j-hui/fidget.nvim", tag = "legacy" }, -- show status for lsp in pop up
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
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			focus = true,
		},
	},
	{
		"utilyre/barbecue.nvim", -- winbar like vscode
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
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
	"rafamadriz/friendly-snippets", -- friendly pre loaded snippets for a whole bunch of languages
	{ "L3MON4D3/LuaSnip", tag = "v1.0.0" },
	"honza/vim-snippets", -- go snippets
	--
	-- telescope
	--
	--
	"nvim-lua/popup.nvim",
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	"benfowler/telescope-luasnip.nvim",
	"mhartington/formatter.nvim", -- formatter
	-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
	-- new formatter to try
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd" } },
				yaml = { "prettierd" },
				go = { "gopls" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				sql = { "pg_format" },
				json = { "prettierd" },
			},
			-- Set up format-on-save
			-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	"ThePrimeagen/harpoon", -- persistent marks
	"voldikss/vim-floaterm", -- floating terminal
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	--
	-- UI improvements
	--
	"stevearc/dressing.nvim", --
	"hoob3rt/lualine.nvim", -- lua line
	"nvim-tree/nvim-web-devicons",
	{ "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" }, -- buffer line
	{
		-- nvim entry screen
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(LazyPlugin)
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	---
	--- Debugging
	---
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"leoluz/nvim-dap-go",
	-- folding
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	-- personal plugins
	-- "~/workbench/testy/testy.nvim"
	--
}
