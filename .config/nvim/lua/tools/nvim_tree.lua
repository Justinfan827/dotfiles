local M = {}
M.setup = function()
	require("nvim-tree").setup({
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		-- disables netrw completely
		disable_netrw = true,
		-- hijack netrw window on startup
		hijack_netrw = true,
		-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
		open_on_tab = false,
		-- hijacks new directory buffers when they are opened.
		-- hijack the cursor in the tree to put it at the start of the filename
		hijack_cursor = false,
		-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
		update_cwd = false,
		-- show lsp diagnostics in the signcolumn
		diagnostics = {
			enable = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		actions = {
			--
			open_file = {
				resize_window = false,
				--
			},
			--
		},
		-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
		update_focused_file = {
			-- enables the feature
			enable = true,
			-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
			-- only relevant when `update_focused_file.enable` is true
			update_cwd = false,
			update_root = true,
			-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
			-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
			ignore_list = {},
		},
		-- configuration options for the system open command (`s` in the tree by default)
		system_open = {
			-- the command to run this, leaving nil should work in most cases
			cmd = nil,
			-- the command arguments as a list
			args = {},
		},
		view = {
			-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
			width = 30,
			-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
			side = "left",
			mappings = {
				-- custom only false will merge the list with the default mappings
				-- if true, it will only use your list to set the mappings
				custom_only = false,
				-- list of mappings to set on the tree manually
				list = {},
			},
		},
	})
end

-- change width of nvim tree
M.toggleWidth = function()
	-- run command :NvimTreeResize to resize commands
	-- hack to set width to 30 (default)
	local key = "jfan-nvim-tree-width"
	local targetWidth = "50"
	if vim.g[key] == "50" then
		targetWidth = "30"
	end
	vim.api.nvim_command(":NvimTreeResize " .. targetWidth)
	vim.api.nvim_command(":NvimTreeToggle")
	vim.api.nvim_command(":NvimTreeToggle")
	vim.g[key] = targetWidth
end

return M
