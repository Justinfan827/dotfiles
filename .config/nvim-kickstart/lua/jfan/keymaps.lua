local map = vim.keymap.set

-- [[ Core Navigation ]]
map('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlights
map('n', ',,', '<cmd>noh<CR>', { desc = 'Clear highlights' })
map({ 'n', 'v' }, 'H', '^', { desc = 'Move to start of line' })
map({ 'n', 'v' }, 'L', '$', { desc = 'Move to end of line' })
map('n', '<CR>', 'G', { desc = 'Jump to line with number prefix' })
map('n', ';', ':', { desc = 'Quick command mode' })

-- [[ Window Navigation ]]
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- [[ Window Splits ]]
map('n', 'ss', '<cmd>split<Return><C-w>w', { desc = 'Split horizontal' })
map('n', 'sv', '<cmd>vsplit<Return><C-w>w', { desc = 'Split vertical' })

-- [[ Insert Mode ]]
map('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })

-- [[ Terminal ]]
map('t', '<Esc><Esc>', '<C-\\\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ File Operations ]]
map('n', ',w', '<cmd>w<cr>', { desc = 'Save file', silent = true })
map('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open file explorer' })

-- [[ Text Editing ]]
map('v', '<leader>p', '"_dP', { silent = true, desc = 'Paste without replacing register' })
map('n', '<leader>vv', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
map('n', 's*', ":let @/'\\<'.expand('<cword>').'\\>'<CR>cgn", { desc = 'Replace and repeat with .' })
map('x', 's*', 'sy:let @/=@s<CR>cgn', { desc = 'Replace selection and repeat' })
map('n', '<C-s>', "<cmd>lua require('treesj').toggle()<CR>", { silent = true, desc = 'Toggle split/join' })

-- Move only sideways in command mode. Using `silent = false` makes movements to be immediately shown.
map('c', '<M-h>', '<Left>', { silent = false, desc = 'Left' })
map('c', '<M-l>', '<Right>', { silent = false, desc = 'Right' })

-- [[ Diagnostics ]]
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix' })

-- [[ Lua Development ]]
map('n', ',sf', '<cmd>source %<CR>', { desc = 'Source current file' })
map('n', ',sl', '<cmd>.lua<CR>', { desc = 'Execute current line as Lua' })
map('v', ',sl', '<cmd>.lua<CR>', { desc = 'Execute selection as Lua' })
map('n', '<leader>rf', '<cmd>luafile %<CR>', { desc = 'Run current file as Lua' })

-- [[ Git (Fugitive) ]]
map('n', '<Leader>gg', '<cmd>Git<CR>', { desc = 'Git status' })
map('n', '<Leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = 'Git diff vertical' })
map('n', '<Leader>gms', '<cmd>Gvdiffsplit origin/master<CR>', { desc = 'Diff against master' })
map('n', '<Leader>gma', '<cmd>Gvdiffsplit origin/main<CR>', { desc = 'Diff against main' })
map('n', '<Leader>gw', '<cmd>Gwrite<CR><CR>', { desc = 'Git add current file' })
map('n', '<Leader>gr', '<cmd>Gread<CR>', { desc = 'Git checkout current file' })
map('n', '<Leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })

-- [[ Copilot ]]
map('n', '<leader>cd', '<cmd>Copilot disable<CR>', { desc = 'Disable Copilot' })
map('n', '<leader>ce', '<cmd>Copilot enable<CR>', { desc = 'Enable Copilot' })
