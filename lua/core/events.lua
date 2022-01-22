--run go import
vim.cmd([[
autocmd BufWritePre *.go lua goimports(1000)
]])
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
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.go lua vim.lsp.buf.formatting()
augroup END
]],
  true
)
