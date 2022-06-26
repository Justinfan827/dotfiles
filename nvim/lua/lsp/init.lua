--vim.cmd 'source /Users/justin/.config/nvim/lua/lsp/coc.vim'
--vim.cmd 'source /Users/justin/.config/nvim/lua/lsp/vim-go.vim'

require("lsp.nvim_lsp")

-- for some reason, splitting into multiple files makes things not work
require("lsp.gopls_lsp")
--require('lsp.lua_lsp')
--require('lsp.tsserver_lsp')
