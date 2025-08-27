-- [[ Leader Keys ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ UI Configuration ]]
vim.g.have_nerd_font = true -- Enable Nerd Font support
vim.opt.shortmess:append 'IWs' -- Suppress intro message and search wrap messages

-- [[ Display Options ]]
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.cursorline = true -- Highlight current line
vim.opt.showmode = false -- Don't show mode (status line shows it)
vim.opt.list = true -- Show whitespace characters
vim.g.indentline_char = '' -- Character for indent guides
vim.o.listchars = 'trail:•,extends:#,nbsp:.,precedes:❮,extends:❯,tab:│ ,leadmultispace:' .. vim.g.indentline_char .. '  '

-- [[ Editor Behavior ]]
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.inccommand = 'split' -- Live preview for substitutions
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor

-- [[ Search Options ]]
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Case-sensitive if uppercase present

-- [[ Split Behavior ]]
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

-- [[ Timing ]]
vim.opt.updatetime = 250 -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence

-- [[ Clipboard ]]
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
end)
