-- core QOL improvements
vim.keymap.set('n', ';', ':', { desc = 'Remap : to ;' })
vim.keymap.set('n', '<CR>', 'G', { desc = 'Jump to line number with 123<CR>' })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move to the start of the line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Move to the end of the line' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('n', ',w', '<cmd>w<cr>', { desc = 'Write to buffer' })
vim.keymap.set('n', 'ss', ':split<Return><C-w>w', { desc = 'Horizontally split window' })
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { desc = 'Vertically split window' })
vim.keymap.set('n', ',,', ':noh<CR>', { desc = 'Clearing out highlights' })
vim.keymap.set('n', '<leader>vv', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Change word under cursor' })
vim.keymap.set('n', 's*', ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn", { desc = 'Replace under cursor and . to repeat' })
vim.keymap.set('x', 's*', 'sy:let @/=@s<CR>cgn')
vim.keymap.set('n', '<C-s>', "<cmd>lua require('treesj').toggle()<CR>", { silent = true, desc = 'Toggle split / join' })

-- sourcing lua files
vim.keymap.set('n', ',sf', '<cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', ',sl', ':.lua<CR>', { desc = 'Lua source current line' })
vim.keymap.set('v', ',sl', ':.lua<CR>', { desc = 'Lua source visually highlighted block' })

-- vim fugitive keymaps
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git diff verfical' })
vim.keymap.set('n', '<Leader>gms', ':Gvdiffsplit origin/master<CR>', { desc = 'Git diff master' })
vim.keymap.set('n', '<Leader>gma', ':Gvdiffsplit origin/main<CR>', { desc = 'Git diff main' })
vim.keymap.set('n', '<Leader>gg', ':Git<CR>', { desc = 'View fugitive git status' })
vim.keymap.set('n', '<Leader>gw', ':Gwrite<CR><CR>', { desc = 'Git write (useful in diff view to pull changes)' })
vim.keymap.set('n', '<Leader>gr', ':Gread<CR>', { desc = 'Git read (useful in diff view to pull changes)' })
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { desc = 'Git blame' })

vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open Oil file explorer' })
