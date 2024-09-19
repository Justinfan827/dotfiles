-- https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
-- The idea is to use Telescope to list my Lua modules, and when I click ctrl+e,
-- it will call the Plenary function to reload the module. So this is how I did it.

local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	keys = {},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	defaults = {
		layout_strategy = "flex",
		layout_config = { height = 0.99, width = 0.99 },
		file_ignore_patterns = {
			".git/",
			"node_modules/*",
			"vendor/*",
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.cycle_history_next,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			},
			n = {
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			},
		},
	},
})

telescope.load_extension("harpoon")
telescope.load_extension("git_worktree")
telescope.load_extension("fzf")
telescope.load_extension("neoclip")
telescope.load_extension("projects")

local M = {}

--
-- Be able to search vimrc dotfiles from anywhere
--
function M.search_nvim()
	require("telescope.builtin").find_files({
		prompt_title = "<VimRC>",
		cwd = "$HOME/.config/nvim",
	})
end

--
-- Be able to search vimrc dotfiles from anywhere
--
function M.git_branches()
	require("telescope.builtin").git_branches({
		mappings = {
			i = {
				["<C-j"] = "git_create_branch",
				["<C-n>"] = false,
			},
		},
	})
end

function M.reload()
	-- Telescope will give us something like colors.lua,
	-- so this function convert the selected entry to
	-- the module name: colors
	local function get_module_name(s)
		local module_name

		module_name = s:gsub("%.lua", "")
		module_name = module_name:gsub("%/", ".")
		module_name = module_name:gsub("%.init", "")

		return module_name
	end

	local prompt_title = "~ neovim modules ~"

	-- sets the path to the lua folder
	local path = "~/.config/nvim/lua"

	local opts = {
		prompt_title = prompt_title,
		cwd = path,
		attach_mappings = function(_, map)
			-- Adds a new map to ctrl+e.
			map("i", "<c-e>", function(_)
				-- these two are very self-explanatory
				local entry = require("telescope.actions.state").get_selected_entry()
				local name = get_module_name(entry.value)

				-- call the helper method to reload the module
				-- and give some feedback
				R(name)
				P(name .. " RELOADED!!!")
			end)

			return true
		end,
	}

	-- call the builtin method to list files
	require("telescope.builtin").find_files(opts)
end

return M
