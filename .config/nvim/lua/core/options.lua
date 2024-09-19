local global = require("core.global")

-- Neovim exposes a global vim variable which serves as an entry point to interact with its APIs from Lua.
-- It provides users with an extended "standard library" of functions as well as various sub-modules.
--
-- For more info: https://github.com/nanotee/nvim-lua-guide/tree/358b6b4273b1fd8949452b0795c4ff1602d8edd6#managing-vim-options
--
--
-- e.g. Setting options? We can use:
--
-- Global options:
--  vim.api.nvim_set_option()
--  vim.api.nvim_get_option()
-- Buffer-local options:
--  vim.api.nvim_buf_set_option()
--  vim.api.nvim_buf_get_option()
-- Window-local options:
--  vim.api.nvim_win_set_option()
--  vim.api.nvim_win_get_option()
local function load_options()
	local global_local = {
		termguicolors = true,
		-- enable mouse for normal + visual mode
		mouse = "nv",
		-- enable folding via treesitter + ufo
		foldcolumn = "1",
		foldlevel = 99,
		foldlevelstart = -1,
		--foldlevelstart = 99,
		foldenable = true,
		errorbells = true,
		visualbell = true,
		hidden = true,
		fileformats = "unix,mac,dos",
		magic = true,
		virtualedit = "block",
		encoding = "utf-8",
		viewoptions = "folds,cursor,curdir,slash,unix",
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
		-- recommended by auto-session plugin
		--sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal",
		clipboard = "unnamedplus",
		wildignorecase = true,
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		backup = false,
		writebackup = false,
		swapfile = false,
		-- directory      = global.cache_dir .. "swag/";
		-- undodir        = global.cache_dir .. "undo/";
		-- backupdir      = global.cache_dir .. "backup/";
		-- viewdir        = global.cache_dir .. "view/";
		-- spellfile      = global.cache_dir .. "spell/en.uft-8.add";
		history = 2000,
		shada = "!,'300,<50,@100,s10,h",
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		smarttab = true,
		shell = "/bin/sh",
		shiftround = true,
		timeout = true,
		ttimeout = true,
		timeoutlen = 500,
		ttimeoutlen = 10,
		updatetime = 100,
		redrawtime = 1500,
		ignorecase = true,
		smartcase = true,
		infercase = true,
		hlsearch = true,
		incsearch = true,
		wrapscan = true,
		complete = ".,w,b,k",
		inccommand = "nosplit",
		grepformat = "%f:%l:%c:%m",
		grepprg = "rg --hidden --vimgrep --smart-case --",
		breakat = [[\ \	;:,!?]],
		startofline = false,
		whichwrap = "h,l,<,>,[,],~",
		splitbelow = true,
		splitright = true,
		switchbuf = "useopen",
		backspace = "indent,eol,start",
		diffopt = "filler,iwhite,internal,algorithm:patience",
		completeopt = "menu,menuone,noselect",
		jumpoptions = "stack",
		showmode = false,
		shortmess = "aoOTIcF",
		scrolloff = 2,
		sidescrolloff = 5,
		ruler = false,
		list = false,
		showtabline = 2,
		winwidth = 30,
		winminwidth = 10,
		pumheight = 15,
		helpheight = 12,
		previewheight = 12,
		showcmd = false,
		cmdheight = 2,
		cmdwinheight = 5,
		equalalways = false,
		laststatus = 3, -- neovim 0.7 global status line across buffers
		display = "lastline",
		showbreak = "↳  ",
		listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
		pumblend = 10,
		winblend = 10,
		syntax = "enable",
	}

	local buffer_local = {
		undofile = true,
		shiftwidth = 2,
		textwidth = 80,
		formatoptions = "1jcroql",
		tabstop = 2,
		softtabstop = -1,
		autoindent = true,
		synmaxcol = 2500,
		expandtab = true,
	}

	local window_local = {
		concealcursor = "niv",
		conceallevel = 0,
		foldenable = true,
		number = true,
		signcolumn = "yes",
		breakindentopt = "shift:2,min:20",
		relativenumber = true,
		wrap = false,
		linebreak = true,
	}

	-- set global options
	for name, value in pairs(global_local) do
		-- vim.o is setting editor options: https://neovim.io/doc/user/options.html#options
		vim.o[name] = value
	end

	-- set buffer-local options
	for name, value in pairs(buffer_local) do
		-- vim.o is setting editor options: https://neovim.io/doc/user/options.html#options
		vim.bo[name] = value
	end
	-- set window-local options
	for name, value in pairs(window_local) do
		-- vim.o is setting editor options: https://neovim.io/doc/user/options.html#options
		vim.wo[name] = value
	end
end

local function load_variables()
	local global_variables = {
		--
		-- vim-gh-line https://github.com/ruanyl/vim-gh-line/blob/master/README.md
		--
		-- set mapping for opening curent line in gh
		gh_line_map = "<leader>bg",
		-- disable default mappings here
		gh_line_blame_map_default = 0,
		-- Use self-deployed GitHub:
		-- gh_github_domain = "git@git.blendlabs.com:blend",
		--
		-- fzf
		--
		fzf_history_dir = "~/.local/share/fzf-history",
		-- floatterm
		floaterm_shell = "fish",
		-- not 100% sure what these do tbh
		--UltiSnipsJumpForwardTrigger = "<C-a>",
		--UltiSnipsJumpBackwardTrigger = "<C-s>"
		--
		--
		--
	}

	for variable, value in pairs(global_variables) do
		-- vim.o is setting editor options: https://neovim.io/doc/user/options.html#options
		vim.g[variable] = value
	end

	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = {
				["+"] = "pbcopy",
				["*"] = "pbcopy",
			},
			paste = {
				["+"] = "pbpaste",
				["*"] = "pbpaste",
			},
			cache_enabled = 0,
		}
	end
end

-- other ex commands
-- Using vim.cmd because there are still things we can't do with lua.
-- Right now we can't create or call ex-commands, same goes for autocommands.
vim.cmd([[
  " abbreviate H on command line to ver h, vertical help
  cnoreabbrev H vert h
]])

vim.cmd([[set t_Co=256]])

-- background is transparent

load_options()
load_variables()
