let g:coc_node_path = "/Users/justin/.nvm/versions/node/v16.8.0/bin/node"   " if changing this, remember to change npm.binPath as well: 
autocmd BufWritePost  *.ts :CocCommand tslint.fixAllProblems
autocmd BufWritePost  *.md :CocCommand markdownlint.fixAll

autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" .............................................................................
" COC settings
" .............................................................................

" close floats when existing insert mode
nmap <ESC> :call coc#float#close_all() <CR>

" coc replace word under cursor
nnoremap <silent> <Leader>cr :CocSearch <C-R><C-W><CR>

" Declare CoC extensions // TODO: move all cocsettings into vimrc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-tslint-plugin',
  \ 'coc-snippets',
  \ 'coc-json',
  \ 'coc-go',
  \ ]

" prettier / eslint based on setup
"if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  "let g:coc_global_extensions += ['coc-prettier']
"endif

"if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  "let g:coc_global_extensions += ['coc-eslint']
"endif
"
" We can create a mapping to show documentation for the word under the cursor in the same way:
"nnoremap <silent> K :call CocAction('doHover')<CR>

" if hidden is not set, TextEdit might fail.
set hidden " Manage multiple buffers effectively: the current buffer can be “sent” to the background without writing to disk. When a background buffer becomes current again, marks and undo-history are remembered. See chapter Buffers to understand this better.
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : 
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use tab for snippets
let g:coc_snippet_next = '<tab>' 


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gD :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> gh :call CocAction('doHover')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Run some code action
nmap <leader>do <Plug>(coc-codeaction)

nmap <silent> <Leader>m <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>n <Plug>(coc-diagnostic-next)
