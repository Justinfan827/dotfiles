-- map is a wrapper around vim api to help set variables
-- in a more vimscript way
-- e.g. If we wanted to do:
-- >> nnoremap <Leader>w :write<CR>
-- we would need to do:
-- >>> vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', {noremap = true})
local map = function(key)
	-- get the extra options
	local opts = { noremap = true }
	for i, v in pairs(key) do
		if type(i) == "string" then
			opts[i] = v
		end
	end

	-- basic support for buffer-scoped keybindings
	local buffer = opts.buffer
	opts.buffer = nil

	if buffer then
		vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
	else
		vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
	end
end

-- https://github.com/nanotee/nvim-lua-guide#defining-mappings
--

-- copy the directory of the current buffer to clipboard
--map {"n", "<leader>c", ":let @+=expand('%:p')<CR>"}
map({ "", "H", "^" })
map({ "", "L", "$" })
-- Jump to line by just typing 123<CR>
map({ "n", "<CR>", "G" })
-- Avoid typing :
map({ "n", ";", ":" })
-- source current lua
map({ "n", "<leader>sl", ":luafile %<CR>" })

-- Quickly edit and source config files
map({ "n", "<leader>ov", ":vs ~/.config/nvim/init.vim<CR>" })
map({ "n", "<leader>oz", ":vs ~/.zshrc<CR>                         " })
map({ "n", "<leader>oc", ":vs ~/.config/nvim/coc-settings.json<CR> " })
map({ "n", "<leader>ot", ":vs ~/.tmux.conf<CR>                     " })
map({ "n", "<leader>og", ":vs ~/.gitconfig<CR>                     " })
-- Split window
map({ "n", "ss", ":split<Return><C-w>w" })
map({ "n", "sv", ":vsplit<Return><C-w>w" })

-- remap escape character to kj
map({ "i", "kj", "<ESC>" })

-- Neo Tree
map({ "n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>" })

-- cd to directory of current file
map({ "n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>" })

map({ "n", "s*", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn" })
map({ "x", "s*", "sy:let @/=@s<CR>cgn" })

-- make page down and up less disorienting
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- make search terms stay in the middle
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Primeagen says no to Q
vim.keymap.set("n", "Q", "<nop>")

-- fugitive mappings
map({ "n", "<Leader>gd", ":Gvdiffsplit<CR>" })
map({ "n", "<Leader>gms", ":Gvdiffsplit origin/master<CR>" })
map({ "n", "<Leader>gma", ":Gvdiffsplit origin/main<CR>" })
map({ "n", "<Leader>gg", ":Git<CR>" })
map({ "n", "<Leader>gw", ":Gwrite<CR><CR>" })
map({ "n", "<Leader>gr", ":Gread<CR>" })
map({ "n", "<Leader>gb", ":Git blame<CR>" })
map({ "n", "<Leader>fct", ":GCheckoutTag<CR>" })

map({ "n", "<leader>gc", ":Gcommit -v -q<CR>" })
map({ "n", "<leader>gt", ":Gcommit -v -q %:p<CR>" })
map({ "n", "<leader>ge", ":Gedit<CR>" })
map({ "n", "<leader>gl", ":silent! Git log<CR>" })
map({ "n", "<leader>go", ":Git checkout<Space>" })

-- <A- means with the mac OS cmd key
-- move lines: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map({ "i", "<A-j>", "<Esc>:m .+1<CR>==gi" })
map({ "i", "<A-k>", "<Esc>:m .-2<CR>==gi" })
map({ "n", "<A-j>", ":m .+1<CR>==" })
map({ "n", "<A-k>", ":m .-2<CR>==" })
map({ "v", "<A-j>", ":m '>+1<CR>gv=gv" })
map({ "v", "<A-k>", ":m '<-2<CR>gv=gv" })

-- this keeps your cursor in place when using J to move the line below above
vim.keymap.set("n", "J", "mzJ`z")

-- This lets me push from vim
map({ "n", "<leader>gps", ":Dispatch! git push<CR>" })
map({ "n", "<leader>gpl", ":Dispatch! git pull<CR>" })

-- no hilight
map({ "n", "<leader><leader>", ":noh<CR>" })

-- .............................................................................
--  FZF mappings
-- .............................................................................
-- Search all files under git root via a project files function
vim.cmd("source $HOME/.config/nvim/lua/core/misc.vim")

-- map {"n", "<C-p>", ":ProjectFiles <CR>"}

-- searching through files using silver searcher
map({ "n", "<Leader>/", ":Ag!<CR>" })
-- fuzzy grep current word under cursor
-- map {"n", "<Leader>ag", ":Ag! <C-R><C-W><CR>", {silent = true}}
-- toggle list
map({ "n", "<leader>sa", ":set nolist!<CR>", { silent = true } })
-- Reload lua module
map({ "n", "<leader>qr", '<cmd>:lua require("tools.telescope").reload()<CR>', { silent = true } })

-- Run go imports
-- map {"n", "<leader>gi", "<cmd>:lua GO_IMPORTS(1000)<CR>", {silent = true}}

-- Search vimrc from anywhere
map({ "n", "<leader>vrc", '<cmd>:lua require("tools.telescope").search_nvim()<CR>', { silent = true } })

map({ "n", "<leader>ct", "<cmd>TroubleToggle<CR>", { silent = true } })

--
-- TELESCOPE mappings
--

-- git work trees
-- -- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-D> - force deletes that worktree
-- git worktrees
map({ "n", "<leader>tg", ':lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', { silent = true } })
map({
	"n",
	"<leader>tc",
	':lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
	{ silent = true },
})

-- write
map({ "n", "<leader>w", "<cmd>w<cr>", { silent = true } })

map({ "n", "<C-p>", ":Telescope find_files <CR>" })
-- map({ "n", "<leader>n", ":Telescope neoclip <CR>" }) -- not working
vim.cmd([[
  nnoremap <silent> <leader>ag <cmd>Telescope grep_string<cr>
  " nnoremap <silent> <leader>/ <cmd>Telescope live_grep<cr>
  nnoremap <silent> <space><space> <cmd>Telescope buffers<cr>
  nnoremap <silent><leader>th <cmd>Telescope help_tags<cr>
]])

-- float term mappings
map({ "n", "<leader>fn", ":FloatermNew<CR>", { silent = false } })
map({ "n", "<leader>ff", ":FloatermToggle<CR>", { silent = false } })
map({ "n", "<leader>fk", ":FloatermKill<CR>", { silent = false } })
map({ "v", "<leader>fn", ":FloatermNew<CR>", { silent = false } })
map({ "v", "<leader>ff", ":FloatermToggle<CR>", { silent = false } })
map({ "v", "<leader>fk", ":FloatermKill<CR>", { silent = false } })

-- harpoon mappings
map({ "n", "<leader>h", '<cmd>:lua require("harpoon.mark").add_file()<CR>', { silent = false } })
map({ "n", "<leader>1", '<cmd>:lua require("harpoon.ui").nav_file(1)<CR>', { silent = false } })
map({ "n", "<leader>2", '<cmd>:lua require("harpoon.ui").nav_file(2)<CR>', { silent = false } })
map({ "n", "<leader>3", '<cmd>:lua require("harpoon.ui").nav_file(3)<CR>', { silent = false } })
map({ "n", "<leader>4", '<cmd>:lua require("harpoon.ui").nav_file(4)<CR>', { silent = false } })
map({ "n", "<leader>5", '<cmd>:lua require("harpoon.ui").nav_file(5)<CR>', { silent = false } })
map({ "n", "<leader>6", '<cmd>:lua require("harpoon.ui").nav_file(6)<CR>', { silent = false } })
map({ "n", "<leader>7", '<cmd>:lua require("harpoon.ui").nav_file(7)<CR>', { silent = false } })
map({ "n", "<leader>8", '<cmd>:lua require("harpoon.ui").nav_file(8)<CR>', { silent = false } })
map({ "n", "<leader>9", '<cmd>:lua require("harpoon.ui").nav_file(9)<CR>', { silent = false } })
map({ "n", "<leader>m", '<cmd>:lua require("harpoon.ui").toggle_quick_menu()<CR>', { silent = false } })
--map {"n", "<leader>m", "<cmd>:Telescope harpoon marks<CR>", {silent = false}}
--map {"n", "<leader>nn", '<cmd>:lua require("harpoon.ui").nav_next()<CR>', {silent = false}}
--map {"n", "<leader>np", '<cmd>:lua require("harpoon.ui").nav_prev()<CR>', {silent = false}}
map({ "n", "<leader><space>", ":Telescope harpoon marks<CR>", { silent = true } })
--

-- keep register when pasting. This is the greatest!
-- deletes and puts it in the  void register
map({ "v", "<leader>p", '"_dP', { silent = true } })

-- spectre mappings
--
-- search and replace current word
map({ "n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { silent = true } })
map({ "n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { silent = true } })
-- search in current file
map({ "n", "<leader>sp", "viw:lua require('spectre').open_file_search()<CR>", { silent = true } })
map({ "v", "<leader>S", "<cmd>lua require('spectre').open_visual()<CR>", { silent = true } })

-- subversive mappings
--map {"n", "<leader>k", "<plug>(SubversiveSubstitute)", {}}
--map {"n", "<leader>kk", "<plug>(SubversiveSubstituteLine)", {}}
--map {"n", "<leader>K", "<plug>(SubversiveSubstituteToEndOfLine)",{}}
--
-- switching golang alternate vs test file
map({ "n", "<leader>d", ":A<CR>", { silent = true } })

-- format with mharrington
-- map {"n", "ff", ":Format<CR>", {silent = true}} -- commented out to try conform.nvim
--map {"n", "<leader>AS", ":AV<CR>", {silent = true}}
--map {"v", "<leader>A", ":A<CR>", {silent = true}}
--map {"v", "<leader>AS", ":AV<CR>", {silent = true}}

-- focus mode
--map {"n", "<leader>z", ":TZAtaraxis<CR>", {silent = true}}

-- undo tree is insane to recover from issues
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- navigation in quick fix and location list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- nice fun one to change the current word under the cursor
vim.keymap.set("n", "<leader>vv", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>gY", '<cmd>lua require"gitlinker".get_repo_url()<cr>', { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>gB",
	'<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
	{ silent = true }
)

-- treesj (split and join lines)
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('treesj').toggle()<CR>", { silent = true })

