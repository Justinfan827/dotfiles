" :GFiles will only find files committed to the repo. This will find the git
" root and run :Files from the git root

function! s:find_files()
    let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_dir != ''
        execute 'GFiles!' git_dir
    else
        execute 'Files!'
    endif
endfunction
command! ProjectFiles execute s:find_files()
nnoremap <leader>p :ProjectFiles<CR>

" toggle coc
function! ToggleCoc()
   if b:coc_enabled == 0
      let b:coc_enabled = 1
      CocStart
      echo 'COC on'
   else
      let b:coc_enabled = 0
      echo 'COC off'
      call coc#rpc#stop()
   endif
endfunction

