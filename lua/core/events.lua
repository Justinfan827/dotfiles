--
-- typescript specific tabs
vim.cmd(
  [[
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
]]
)

-- highlight on yank
vim.cmd([[
 au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
]])

-- auto format certain files (using formatter plugin)
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tf,*.lua FormatWrite
augroup END
]],
  true
)

-- auto format certain files (using lsp formatter)
vim.api.nvim_exec(
  [[
augroup GO_LSP
	autocmd!
	autocmd BufWritePost *.go :silent! lua vim.lsp.buf.formatting()
	autocmd BufWritePost *.go :silent! lua GO_IMPORTS(3000)
augroup END
]],
  true
)

local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command("augroup " .. group_name)
    api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      api.nvim_command(command)
    end
    api.nvim_command("augroup END")
  end
end

local autoCommands = {
  -- other autocommands
  open_folds = {
    {"BufReadPost,FileReadPost", "*", "normal zR"} -- open folds by default when using treesitter folding
  }
}

M.nvim_create_augroups(autoCommands)
