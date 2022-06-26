" .............................................................................
" Vim-go configs
" .............................................................................
" disable all linters as that is taken care of by coc.nvim
"

function! VimGoSetup()
  " vim-go related mappings
  au FileType go nmap <Leader>r <Plug>(go-run)
  au FileType go nmap <Leader>b <Plug>(go-build)
  au FileType go nmap <Leader>t <Plug>(go-test)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>s <Plug>(go-implements)
  au FileType go nmap <Leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>e <Plug>(go-rename)
  au FileType go nmap <Leader>gi <Plug>(go-imports)
  au FileType go nmap <Leader>gI <Plug>(go-install)
  au FileType go nmap <Leader>gD <Plug>(go-def-split)
  au FileType go nmap <Leader>gd <Plug>(go-def)
  au FileType go nmap <Leader>gv<Plug>(go-def-vertical)
  au Filetype go nmap <leader>gat <Plug>(go-alternate-edit)
  au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
  let g:go_auto_type_info = 1
  let g:go_fmt_experimental = 0
  let g:go_metalinter_autosave = 0
  "let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  let g:go_metalinter_enabled = []
  let g:go_term_enabled = 0
  let g:go_term_mode = "vertical"
" let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_chan_whitespace_error = 1
  let g:go_diagnostics_enabled = 0
  " share server with coc
  let g:go_gopls_options = ['-remote=auto', '--debug=localhost=6060']

  " don't jump to errors after metalinter is invoked
  let g:go_jump_to_error = 0

  " run go imports on file save
  let g:go_fmt_command = "gofmt"

  " let coc do this
  let g:go_code_completion_enabled = 0
  " debug go
  "let g:go_debug = ["shell-commands", "debugger-state", "lsp"]

endfunction
call VimGoSetup()
