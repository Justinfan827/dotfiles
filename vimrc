scriptencoding utf-8
set encoding=utf-8
" Vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
    
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif  
call plug#begin('~/.vim/plugged')

" Fzf for vim.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Helpers for unix
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf.vim'

" General
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'

" Theme and styling
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'drewtempelmeyer/palenight.vim'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'gabrielelana/vim-markdown', { 'for': ['markdown'] }
Plug 'hail2u/vim-css3-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'posva/vim-vue'
Plug 'reasonml-editor/vim-reason-plus', { 'do': 'npm i -g ocaml-language-server' }
Plug 'sheerun/vim-polyglot'
"
" Language formatter
Plug 'sbdchd/neoformat'

" Quoting/parenthesizing
" Note: i'm using coc pairs to run pair closing
Plug 'tpope/vim-surround'
" Allow vim to repeat commands from vim-surround!
Plug 'tpope/vim-repeat'
" This is a simple plugin that helps to end certain structures automatically. 
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'

" Emmet snippets
"Plug 'mattn/emmet-vim'

" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
call plug#end()

" --------------------- Functionality stuff -----------------------
filetype plugin on
set undodir=~/.vim/undodir
" change directory to open buffer?
"set autochdir
"---------------------------- UI stuff ----------------------------
colorscheme gruvbox
set background=dark
set t_Co=256
" So highlighting isnt all weird
let g:gruvbox_invert_selection=0
" Git gutter configs
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
syntax on
set shortmess=atI                  " Don't show the intro message when starting vim
set title                          " set the terminal title
set ruler                          "show cursor position
set relativenumber                 " show relative line number
set rulerformat=%10(%l,%c%V%)
set laststatus=2                   "always show status line
set cursorline                     "highlight current line
set number                         "show line numbers
set numberwidth=5
set hlsearch                       "highlight search keywords
set noshowmode                     "Don't show bottom line since i'm using lightline.vim

" .............................................................................
" .............................................................................
" BASIC MAPPINGS
" .............................................................................
" .............................................................................

" Avoid typing :
nnoremap ; :
"  Managing window splits
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" remap escape character to kj
inoremap kj  <ESC>
" Direction of opening windows
set splitbelow
set splitright
" easier way to get to beginning end of line
map H ^
map L $
" erase highlights with space
nnoremap <Leader><space> :let @/=""<cr>
let mapleader = ","
" Press * to search for the term under the cursor or a visual selection and
" " then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" " restricted to the previously visually selected range. You can do that by
" " pressing *, visually selecting the range you want it to apply to and then
" " press a key below to replace all instances of it in the current selection.
noremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>
" Type a replacement term and press . to repeat the replacement again. Useful
" " for replacing a few instances of the term (comparable to multiple
" cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Quickly edit and source config files
noremap <leader>ov :tabe ~/.vimrc<CR>
noremap <leader>oz :tabe ~/.zshrc<CR>
noremap <leader>oc :tabe ~/.config/nvim/coc-settings.json<CR>
noremap <leader>so :source ~/.config/nvim/init.vim<CR>
noremap <leader>ot :tabe ~/.tmux.conf<CR>
noremap <leader>og :tabe ~/.gitconfig<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" .............................................................................
" COC settings
" .............................................................................

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
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gD :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> gh :call CocAction('doHover')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

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

nmap <silent> <Leader>m <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>n <Plug>(coc-diagnostic-next)

" search current word under cursor
nnoremap <silent> <Leader>ag :Find <C-R><C-W><CR>

" .............................................................................
" fugitive mappings
" .............................................................................

nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gg :Gstatus<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gb :Git blame<CR>

" .............................................................................
"  FZF mappings
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Launch fzf with CTRL+P.
nnoremap <C-p> :GFiles <CR>
" Map a few common things to do with FZF.
nnoremap <Leader><Enter> :Buffers<CR>
nnoremap <Leader>l :Lines<CR>
nmap <Leader>/ :PRg<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)


" .............................................................................
" scrooloose/nerdtree mappings
" .............................................................................

" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>ne g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" .............................................................................
" VimGrepper mappings
" .............................................................................
" Use vim grepper to search
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" .............................................................................
" .............................................................................
" BASIC CONFIGS
" .............................................................................
" .............................................................................

" show trailing spaces, tabs, and end of lines
set listchars=tab:>-,trail:·,eol:$,nbsp:_
nmap <silent> <leader>ss :set nolist!<CR>
" ------------------------ Spaces and indenting --------------------------- 

" python spacing
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Allow scroll in vim  
if !has('nvim')
	set ttymouse=xterm2
endif
filetype plugin indent on
set mouse=a " enable mouse for scrolling and resizing
" Use :help 'option' to see the documentation for the given option.

set autoindent                              " maintain inident of current line
set backspace=indent,eol,start              " Allow backspacing over indention, line breaks and insertion start
set history=1000                            " Bigger history of executed commands
set showcmd                                 " show incomplete commands at the bottom
set noerrorbells                            "disable beep on errors
set complete-=i
set smarttab
set expandtab                               " Use spaces for tab
set shiftwidth=4                            " '>' indents with 4 spaces
set tabstop=4                               " Show existing tab with 4 spaces width
set softtabstop=4

" Disable backup files
set nobackup


set undofile "Maintain undo history between sessions
set undodir=~/.vim/undodir "Save undo files in specified dir

autocmd BufNewFile,BufRead *.rvt set filetype=tcl
autocmd BufNewFile,BufRead *.vue set filetype=vue
autocmd BufNewFile,BufRead Dockerfile.dev set filetype=Dockerfile
autocmd BufNewFile,BufRead *.test set filetype=tcl
autocmd BufNewFile,BufRead Jenkinsfile* set filetype=groovy
"autocmd BufNewFile,BufRead *\.*rc set filetype=json
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

"-- Search --
set incsearch                      "dynamically search term as you type (incremental search)
set ignorecase                     "case-insensitive search
set smartcase                      "unless there's an uppercase letter in the keyword

set laststatus=2
set wildmenu                       "have enhanced command line completion


if !&scrolloff
  set scrolloff=1                  "Have an extra line on top and below when scrolling
endif

" ----------------------------
" ---- File type settings ----
" ----------------------------
autocmd BufNewFile,BufRead .env.* set filetype=sh

"" Allow color schemes to do bright colors without forcing bold.
"if &t_Co == 8 && $TERM !~# '^Eterm'
  "set t_Co=16
"endif

""Note: matchit.vim matches if statements, and various other matches. Load matchit.vim, but only if the user hasn't installed a newer version.
"if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  "runtime! macros/matchit.vim
"endif
" Disable background color erase
set t_ut=
" .............................................................................
" Vim-go configs
" .............................................................................
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" .............................................................................
" Polyglot configs
" .............................................................................
let g:polyglot_disabled = ['css', 'markdown']

" .............................................................................
" NERDTree configs
" .............................................................................
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1

" .............................................................................
" Emmet configs
" .............................................................................
let g:user_emmet_leader_key='\'
let g:user_emmet_settings = {
  \  'javascript' : {
    \      'extends' : 'jsx',
    \  },
  \}


" .............................................................................
" NeoFormat configs
" .............................................................................
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_python = ['black']

" .............................................................................
" lightline configs
" .............................................................................
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }
"let g:lightline = {
      "\ 'colorscheme': 'wombat',
      "\ 'active': {
      "\   'left': [ [ 'mode', 'paste' ],
      "\             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      "\ },
      "\ 'component_function': {
      "\   'gitbranch': 'FugitiveHead',
      "\   
      "\ },
      "\ }
set statusline^=%{coc#status()}

" .............................................................................
" FZF configs
" .............................................................................
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \ fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)
