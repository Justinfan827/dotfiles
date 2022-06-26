-- map is a wrapper around vim api to help set variables
-- in a more vimscript way
-- e.g. If we wanted to do:
-- >> nnoremap <Leader>w :write<CR>
-- we would need to do:
-- >>> vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', {noremap = true})
local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
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
map {"n", "<leader>c", ":let @+=expand('%:p')<CR>"}
map {"", "H", "^"}
map {"", "L", "$"}
-- Jump to line by just typing 123<CR>
map {"n", "<CR>", "G"}
-- Avoid typing :
map {"n", ";", ":"}
-- source current lua
map {"n", "<leader>sl", ":luafile %<CR>"}

-- Quickly edit and source config files
map {"n", "<leader>ov", ":vs ~/.config/nvim/init.vim<CR>"}
map {"n", "<leader>oz", ":vs ~/.zshrc<CR>                         "}
map {"n", "<leader>oc", ":vs ~/.config/nvim/coc-settings.json<CR> "}
map {"n", "<leader>ot", ":vs ~/.tmux.conf<CR>                     "}
map {"n", "<leader>og", ":vs ~/.gitconfig<CR>                     "}
-- Split window
map {"n", "ss", ":split<Return><C-w>w"}
map {"n", "sv", ":vsplit<Return><C-w>w"}

-- remap escape character to kj
map {"i", "kj", "<ESC>"}

-- NVIMTree
-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them
--map{'n','<C-n>' ,':NvimTreeToggle<CR>'}
map {"n", "<leader>r", ":NvimTreeRefresh<CR>"}
map {"n", "<C-n>", ":NvimTreeFindFileToggle<CR>"}

-- cd to directory of current file
map {"n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>"}
-- JSON.stringify from insert mode; Puts focus inside parentheses
map {"i", "clj", "console.log(JSON.stringify(,null, 2))<Esc>==f,i"}
-- JSON.stringify from visual mode on next line, puts visual selection inside parentheses
map {"v", "clj", "yocll<Esc>p"}
-- JSON.stringify from normal mode, inserted on next line with word your on inside parentheses
map {"n", "clj", "yiwoclj<Esc>p"}

-- Console log from insert mode; Puts focus inside parentheses
map {"i", "cll", "console.log({});<Esc>==f{a"}
-- Console log from visual mode on next line, puts visual selection inside parentheses
map {"v", "cll", '"ayoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>'}
-- Console log from normal mode, inserted on next line with word your on inside parentheses
map {"n", "cl'", '"ayiwoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>'}
map {"n", "cll", '"ayiwoconsole.log({<C-R>a});<Esc>'}
-- add new line in insert and normal mode
map {"i", "cln", "console.log('\\n\\n\\n');<Esc>"}

-- fmt.Print from insert mode; Puts focus inside parentheses
map {"i", "fpp", "fmt.Println()<Esc>==f(a"}
map {"i", "fpq", 'fmt.Println("")<Esc>==f"a'}
-- Console log from visual mode on next line, puts visual selection inside parentheses
map {"v", "fpp", "yofpp<Esc>p"}
-- Console log from normal mode, inserted on next line with word your on inside parentheses
map {"n", "fpp", "yiwofpp<Esc>p"}
map {"i", "fpn", 'fmt.Printf("\\n\\n\\n")<Esc>==f(a'}

map {"n", "s*", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn"}
map {"x", "s*", "sy:let @/=@s<CR>cgn"}

-- fugitive mappings
map {"n", "<Leader>gd", ":Gvdiffsplit<CR>"}
map {"n", "<Leader>gm", ":Gvdiffsplit origin/master<CR>"}
map {"n", "<Leader>gg", ":Git<CR>"}
map {"n", "<Leader>gw", ":Gwrite<CR><CR>"}
map {"n", "<Leader>gr", ":Gread<CR>"}
map {"n", "<Leader>gb", ":Git blame<CR>"}
map {"n", "<Leader>fct", ":GCheckoutTag<CR>"}

map {"n", "<leader>gc", ":Gcommit -v -q<CR>"}
map {"n", "<leader>gt", ":Gcommit -v -q %:p<CR>"}
map {"n", "<leader>ge", ":Gedit<CR>"}
map {"n", "<leader>gl", ":silent! Git log<CR>"}
map {"n", "<leader>go", ":Git checkout<Space>"}

-- This lets me push from vim
map {"n", "<leader>gps", ":Dispatch! git push<CR>"}
map {"n", "<leader>gpl", ":Dispatch! git pull<CR>"}

-- This lets me open git branches from vim  git fzf checkout extension
map {"n", "<leader>fb", ":GBranches<CR>"}

-- This lets me open git branches from vim  git fzf checkout extension
map {"n", "<leader>gss", ":GStash<space>"}
map {"n", "<leader>gsl", ":GStashList<CR>"}

-- no hilight
map {"n", "<leader><space>", ":noh<CR>"}

-- .............................................................................
--  FZF mappings
-- .............................................................................
-- Search all files under git root
vim.cmd "source /Users/justin/.config/nvim/lua/core/misc.vim"

map {"n", "<C-p>", ":ProjectFiles <CR>"}
--map {"n", "<C-p>", ":Telescope git_files <CR>"}

-- Open buffers
--map {"n", "<space><space>", ":Buffers!<CR>"}

-- Open all lines
map {"n", "<Leader>l", ":Lines<CR>"}

-- searching through files using silver searcher
map {"n", "<Leader>/", ":Ag!<CR>"}

-- Search current word under cursor
map {"n", "<Leader>ag", ":Ag! <C-R><C-W><CR>", {silent = true}}

-- toggle list
map {"n", "<leader>sa", ":set nolist!<CR>", {silent = true}}

-- Reload lua module
map {"n", "<leader>qr", '<cmd>:lua require("tools.telescope").reload()<CR>', {silent = true}}

-- Run go imports
map {"n", "<leader>gi", "<cmd>:lua GO_IMPORTS(1000)<CR>", {silent = true}}

-- telescope
--

-- Search vimrc from anywhere
map {"n", "<leader>vrc", '<cmd>:lua require("tools.telescope").search_nvim()<CR>', {silent = true}}
-- git work trees
-- -- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-D> - force deletes that worktree
map {"n", "<leader>wt", '<cmd>:lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', {silent = true}}

-- float term mappings
map {"n", "<leader>fn", ":FloatermNew<CR>", {silent = false}}
map {"n", "<leader>ff", ":FloatermToggle<CR>", {silent = false}}
map {"n", "<leader>fk", ":FloatermKill<CR>", {silent = false}}
map {"v", "<leader>fn", ":FloatermNew<CR>", {silent = false}}
map {"v", "<leader>ff", ":FloatermToggle<CR>", {silent = false}}
map {"v", "<leader>fk", ":FloatermKill<CR>", {silent = false}}

-- harpoon mappings
map {"n", "<leader>h", '<cmd>:lua require("harpoon.mark").add_file()<CR>', {silent = false}}
map {"n", "<leader>1", '<cmd>:lua require("harpoon.ui").nav_file(1)<CR>', {silent = false}}
map {"n", "<leader>2", '<cmd>:lua require("harpoon.ui").nav_file(2)<CR>', {silent = false}}
map {"n", "<leader>3", '<cmd>:lua require("harpoon.ui").nav_file(3)<CR>', {silent = false}}
map {"n", "<leader>4", '<cmd>:lua require("harpoon.ui").nav_file(4)<CR>', {silent = false}}
map {"n", "<leader>5", '<cmd>:lua require("harpoon.ui").nav_file(5)<CR>', {silent = false}}
map {"n", "<leader>6", '<cmd>:lua require("harpoon.ui").nav_file(6)<CR>', {silent = false}}
map {"n", "<leader>7", '<cmd>:lua require("harpoon.ui").nav_file(7)<CR>', {silent = false}}
map {"n", "<leader>8", '<cmd>:lua require("harpoon.ui").nav_file(8)<CR>', {silent = false}}
map {"n", "<leader>9", '<cmd>:lua require("harpoon.ui").nav_file(9)<CR>', {silent = false}}
map {"n", "<leader>m", '<cmd>:lua require("harpoon.ui").toggle_quick_menu()<CR>', {silent = false}}
--map {"n", "<leader>nn", '<cmd>:lua require("harpoon.ui").nav_next()<CR>', {silent = false}}
--map {"n", "<leader>np", '<cmd>:lua require("harpoon.ui").nav_prev()<CR>', {silent = false}}
--map {"n", "<leader><space>", ":Telescope harpoon marks<CR>", {silent = true}}

-- spectre mappings
--
-- search current word
map {"n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", {silent = true}}
map {"n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", {silent = true}}
-- search in current file
map {"n", "<leader>sp", "viw:lua require('spectre').open_file_search()<CR>", {silent = true}}
map {"v", "<leader>S", "<cmd>lua require('spectre').open_visual()<CR>", {silent = true}}

-- subversive mappings
--map {"n", "<leader>k", "<plug>(SubversiveSubstitute)", {}}
--map {"n", "<leader>kk", "<plug>(SubversiveSubstituteLine)", {}}
--map {"n", "<leader>K", "<plug>(SubversiveSubstituteToEndOfLine)",{}}
--
-- switching golang alternate vs test file
map {"n", "<leader>d", ":A<CR>", {silent = true}}
--map {"n", "<leader>AS", ":AV<CR>", {silent = true}}
--map {"v", "<leader>A", ":A<CR>", {silent = true}}
--map {"v", "<leader>AS", ":AV<CR>", {silent = true}}

-- regex folding
--map {"n", "<leader>F", ":setlocal foldmethod=manual<CR><CR>"}
-- https://stackoverflow.com/questions/51484595/search-a-pattern-and-fold-the-matching-lines-in-gvim
map {
  "n",
  "<leader>Z",
  ":setlocal foldexpr=(getline(v:lnum)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>"
}
map {
  "n",
  "<leader>z",
  ":setlocal foldexpr=(getline(v:lnum)=~@/)?1:0 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>"
}

-- my own git branches with updated mappings
map {"n", "<leader>tb", '<cmd>:lua require("tools.telescope").git_branches()<CR>', {silent = true}}

-- focus mode
--map {"n", "<leader>z", ":TZAtaraxis<CR>", {silent = true}}

---- hopping around!
map {
  "n",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
  {}
}
map {
  "n",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
  {}
}
map {
  "o",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
  {}
}
map {
  "o",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
  {}
}
map {
  "n",
  "<leader>e",
  "<cmd> lua require'hop'.hint_words({})<cr>",
  {}
}
map {
  "v",
  "<leader>e",
  "<cmd> lua require'hop'.hint_words({})<cr>",
  {}
}
map {
  "o",
  "<leader>e",
  "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>",
  {}
}

vim.cmd(
  [[
  nnoremap <silent> <leader>tf <cmd>Telescope find_files<cr>
  nnoremap <silent> <leader>ta <cmd>Telescope grep_string<cr>
  nnoremap <silent> <leader>tr <cmd>Telescope live_grep<cr>
  nnoremap <silent> <space><space> <cmd>Telescope buffers<cr>
  nnoremap <silent><leader>th <cmd>Telescope help_tags<cr>
]]
)
