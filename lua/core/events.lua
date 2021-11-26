-- run go import
vim.cmd([[
  autocmd BufWritePre *.go lua goimports(1000)
]])

