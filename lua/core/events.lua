-- run go import
vim.cmd([[
  autocmd BufWritePre *.go lua goimports(1000)
]])


-- auto format certain files
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tf,*.lua FormatWrite
augroup END
]], true)
