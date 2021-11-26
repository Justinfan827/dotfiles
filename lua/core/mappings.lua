--
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
    if type(i) == 'string' then opts[i] = v end
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
map{ 'n', '<leader>c', ":let @+=expand('%:p')<CR>"}
map{'', 'H', '^'}
map{'', 'L', '$'}
-- Jump to line by just typing 123<CR>
map{'n','<CR>','G'}
-- Avoid typing :
map{'n', ';', ':'}
-- source nvim config
map{'n','<leader>so', ':source ~/.config/nvim/init.vim<CR>'}

-- Quickly edit and source config files
map {'n', '<leader>ov', ':vs ~/.config/nvim/init.vim<CR>'}
map {'n', '<leader>oz', ':vs ~/.zshrc<CR>                         '}
map {'n', '<leader>oc', ':vs ~/.config/nvim/coc-settings.json<CR> '}
map {'n', '<leader>ot', ':vs ~/.tmux.conf<CR>                     '}
map {'n', '<leader>og', ':vs ~/.gitconfig<CR>                     '}
-- Split window
map{'n', 'ss',':split<Return><C-w>w'  }
map{'n', 'sv', ':vsplit<Return><C-w>w' }

-- remap escape character to kj
map{'i', 'kj', '<ESC>'}

-- NVIMTree
-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them
--map{'n','<C-n>' ,':NvimTreeToggle<CR>'}
map{'n', '<leader>r' ,':NvimTreeRefresh<CR>'}
map{'n', '<C-n>', ':NvimTreeFindFileToggle<CR>' }


-- cd to directory of current file
map{'n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>' }
-- JSON.stringify from insert mode; Puts focus inside parentheses
map{'i', 'clj', 'console.log(JSON.stringify(,null, 2))<Esc>==f,i'}
-- JSON.stringify from visual mode on next line, puts visual selection inside parentheses
map{'v', 'clj', 'yocll<Esc>p'}
-- JSON.stringify from normal mode, inserted on next line with word your on inside parentheses
map{'n', 'clj', 'yiwoclj<Esc>p'}

-- Console log from insert mode; Puts focus inside parentheses
map {'i','cll', 'console.log({});<Esc>==f{a'}
-- Console log from visual mode on next line, puts visual selection inside parentheses
map{'v' ,'cll', 'yocll<Esc>p'}
-- Console log from normal mode, inserted on next line with word your on inside parentheses
map{'n' ,'cll', 'yiwocll<Esc>p'}
-- add new line in insert and normal mode
map{'i' ,'cln', "console.log('\\n\\n\\n');<Esc>"}

-- fmt.Print from insert mode; Puts focus inside parentheses
map{'i', 'fpp', 'fmt.Println()<Esc>==f(a'}
map{'i', 'fpq', 'fmt.Println("")<Esc>==f"a'}
-- Console log from visual mode on next line, puts visual selection inside parentheses
map{'v', 'fpp','yofpp<Esc>p'}
-- Console log from normal mode, inserted on next line with word your on inside parentheses
map{'n' ,'fpp', 'yiwofpp<Esc>p'}
map{'i' ,'fpn', 'fmt.Printf("\\n\\n\\n")<Esc>==f(a'}

map{'n', 's*', ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn"}
map{'x' , 's*', "sy:let @/=@s<CR>cgn"}
-- fugitive mappings
--
map{'n','<Leader>gd', ':Gdiff<CR>'               }
map{'n','<Leader>gm', ':Gdiff origin/master<CR>' }
map{'n','<Leader>gg', ':Git<CR>'                 }
map{'n','<Leader>gw', ':Gwrite<CR><CR>'          }
map{'n','<Leader>gr', ':Gread<CR>'               }
map{'n','<Leader>gb', ':Git blame<CR>'           }
map{'n','<Leader>fct', ':GCheckoutTag<CR>'       }

map{'n', '<leader>gc', ':Gcommit -v -q<CR>'}
map{'n', '<leader>gt', ':Gcommit -v -q %:p<CR>'}
map{'n', '<leader>ge', ':Gedit<CR>'}
map{'n', '<leader>gl', ':silent! Git log<CR>'}
map{'n', '<leader>gm', ':Gmove<Space>'}
map{'n', '<leader>go', ':Git checkout<Space>'}

-- This lets me push from vim
map{'n', '<leader>gps', ':Dispatch! git push<CR>' }
map{'n', '<leader>gpl', ':Dispatch! git pull<CR>' }

-- This lets me open git branches from vim  git fzf checkout extension
map{'n', '<leader>fb', ':GBranches<CR>'}

-- This lets me open git branches from vim  git fzf checkout extension
map{'n', '<leader>gss', ':GStash<space>'}
map{'n', '<leader>gsl', ':GStashList<CR>'}


-- .............................................................................
--  FZF mappings
-- .............................................................................
-- Search all files under git root
vim.cmd 'source /Users/justin/.config/nvim/lua/core/misc.vim'

map{'n', '<C-p>', ':ProjectFiles <CR>'}

-- Open buffers
map{'n','<space><space>',':Buffers!<CR>'}

-- Open all lines
map{'n', '<Leader>l', ':Lines<CR>'}

-- searching through files using silver searcher
map{'n', '<Leader>/', ':Ag!<CR>'}

-- Search current word under cursor
map{'n', '<Leader>ag', ':Ag! <C-R><C-W><CR>', { silent = true }}
-- toggle coc
map{'n', '<Leader>h', ':call ToggleCoc()<cr>'}

-- lsp config
--map{'n', '<silent> gd',' <cmd>lua vim.lsp.buf.definition()<CR>          '}
--map{'n', '<silent> gD',' <cmd>lua vim.lsp.buf.declaration()<CR>         '}
--map{'n', '<silent> gr',' <cmd>lua vim.lsp.buf.references()<CR>          '}
--map{'n', '<silent> gi',' <cmd>lua vim.lsp.buf.implementation()<CR>      '}
--map{'n', '<silent> K    ',' <cmd>lua vim.lsp.buf.hover()<CR>            '}
--map{'n', '<silent> <C-k>',' <cmd>lua vim.lsp.buf.signature_help()<CR>   '}
--map{'n', '<silent> <C-n>',' <cmd>lua vim.lsp.diagnostic.goto_prev()<CR> '}
--map{'n', '<silent> <C-p>',' <cmd>lua vim.lsp.diagnostic.goto_next()<CR> '}

-- toggle list
map{'n', '<leader>sa', ':set nolist!<CR>', { silent = true }}

-- Reload lua module
map{'n', '<leader>qr', '<cmd>:lua require("tools.telescope").reload()<CR>', { silent = true }}

-- telescope
--
vim.cmd([[
  nnoremap <silent> <leader>a <cmd>Telescope find_files<cr>
  nnoremap <silent> <leader>r <cmd>Telescope live_grep<cr>
  nnoremap <silent> <leader><leader> <cmd>Telescope buffers<cr>
  nnoremap <silent><leader>t <cmd>Telescope help_tags<cr>
]])

