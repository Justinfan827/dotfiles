local whichKey = require("which-key")

local setup = {
	presets = "modern",
	-- window = {
	-- 	border = "rounded",
	-- 	position = "bottom",
	-- 	margin = { 1, 0, 1, 0 },
	-- 	padding = { 2, 2, 2, 2 },
	-- 	winblend = 0,
	-- },
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
	show_help = true,
}

whichKey.setup(setup)
