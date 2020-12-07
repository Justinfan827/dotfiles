scriptencoding utf-8
set encoding=utf-8

" Vimplug: for managing extensions.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif  
call plug#begin('~/.vim/plugged')

" Fzf for vim: fuzzy search (ESSENTIAL)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Helpers for unix
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf.vim'

" General
Plug 'tpope/vim-fugitive' " git wrapper in vim
Plug 'tpope/vim-rhubarb' " link to git repo quickly
Plug 'stsewd/fzf-checkout.vim' " checkout git branches in vim
Plug 'itchyny/vim-gitbranch' " add git branch to your lightline
Plug 'mhinz/vim-grepper' " grep easily
Plug 'tpope/vim-unimpaired' " nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
Plug 'christoomey/vim-tmux-navigator' " help navigate with vim / tmux splits
Plug 'airblade/vim-rooter' " Changes vim working directory to the project root (helpful for grepping tools)
Plug 'qpkorr/vim-bufkill' " kill buffer with :BD without killing session

" Nvim typescript (experimenting)
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"" For async completion
"Plug 'Shougo/deoplete.nvim'
"Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

"" For Denite features
"Plug 'Shougo/denite.nvim'

"" Enable deoplete at startup
"let g:deoplete#enable_at_startup = 1

" Theme and styling
Plug 'fatih/molokai'
Plug 'sainnhe/gruvbox-material'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'drewtempelmeyer/palenight.vim'
"Plug 'ryanoasis/vim-devicons' " Add icons! doesn't work with fira font though
Plug 'scrooloose/nerdtree'  " NERDTree directory tree
Plug 'scrooloose/nerdcommenter' " Key binding to comment out stuff

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC: Intellisense engine 
"Plug 'dense-analysis/ale'

" Extensions for different languages 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'gabrielelana/vim-markdown', { 'for': ['markdown'] }
Plug 'hail2u/vim-css3-syntax'
Plug 'posva/vim-vue'
" .............................................................................
" Polyglot configs
" .............................................................................
let g:polyglot_disabled = ['css', 'markdown']

Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim' " TS language extension
Plug 'peitalin/vim-jsx-typescript' " TSX language extension
hi tsxTagName guifg=#E06C75

"Plug 'HerringtonDarkholme/yats.vim' " JS language extension
let g:yats_host_keyword = 1 " configure yats to highlight host specific keywords like addEventListener. Default is 1. Set it 0 to turn off highlighting.
set re=0 "Old regexp engine will incur performance issues for yats and old engine is usually turned on by other plugins.

" Quoting/parenthesizing Note: i'm using coc pairs to run pair closing
Plug 'tpope/vim-surround' " amazing pugin to surround stuff
Plug 'tpope/vim-repeat' " Allow vim to repeat commands from vim-surround!
Plug 'tpope/vim-endwise' " This is a simple plugin that helps to end certain structures automatically. 
Plug 'jiangmiao/auto-pairs'


" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
call plug#end()

" .............................................................................
" .............................................................................
" Basic Functionality
" .............................................................................
" .............................................................................

filetype plugin on
set undodir=~/.vim/undodir


" ......................... folding ...........................
if has('folding')
  if has('windows')
    let &fillchars='vert: ' " less cluttered vertical window separators
  endif
    "set foldmethod=syntax "syntax highlighting items specify folds
    set foldmethod=indent "not as cool as syntax folding, but faster
    "set foldcolumn=1 "defines 1 col at window left, to indicate folding
    let javaScript_fold=1 "activate folding by JS syntax
    set foldlevelstart=99               " start unfolded
endif

" nvim setting
let g:python3_host_prog = "/usr/local/bin/python3"
let g:python_host_prog = "/usr/local/bin/python2"

" .............................................................................
" .............................................................................
" UI SETTINGS
" .............................................................................
" .............................................................................

" ......................... theming configs ...........................
" Set terminal colors
if has('termguicolors')
  set termguicolors
endif

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set t_Co=256 " 256 colors in vim

" ......................... Gruvbox configs ...........................
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 0 
let g:gruvbox_material_disable_italic_comment = 1
set background=dark " Use gruvbox dark

"let g:palenight_terminal_italics=1 "

" Theme selection 
colorscheme gruvbox-material      " Note: this should be placed after all theming configs
"colorscheme palenight              " Note: this should be placed after all configs



" ......................... GitGutter configs ...........................
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

" ......................... Basic UI stuff configs ...........................
syntax on
set shortmess=atI                  " Don't show the intro message when starting vim
set title                          " Set the terminal title
set ruler                          " Show cursor position
set relativenumber                 " Show relative line number
set rulerformat=%10(%l,%c%V%)
set laststatus=2                   " Always show status line
set cursorline                     " Highlight current line
set number                         " Show line numbers
set numberwidth=5
set hlsearch                       " Highlight search keywords
set noshowmode                     " Don't show bottom line since i'm using lightline.vim
set nowrap

" .............................................................................
" .............................................................................
" BASIC MAPPINGS
" .............................................................................
" .............................................................................

" Jump to line by just typing 123<CR>
nnoremap <CR> G
" Avoid typing :
nnoremap ; :
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

" mapping the leader key
let mapleader = ","

" erase highlights with leader key, then space
nnoremap <Leader><space> :noh<cr>

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
noremap <leader>ot :tabe ~/.tmux.conf<CR>
noremap <leader>og :tabe ~/.gitconfig<CR>
noremap <leader>so :source ~/.config/nvim/init.vim<CR>

" close all location and quickfix lists
nmap <leader>l :windo lcl\|ccl<CR>

" folding
"nnoremap <> za         " toggle current fold
" Fold everything / unfold everything
nnoremap <expr> <leader>z &foldlevel ? 'zM' :'zR' "

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y
vnoremap  <leader>Y  "+Y
nnoremap  <leader>Y  "+Y
" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" cd to directory of current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" JSON.stringify from insert mode; Puts focus inside parentheses
imap clj JSON.stringify(,null, 2)<Esc>==f(a
" JSON.stringify from visual mode on next line, puts visual selection inside parentheses
vmap clj yocll<Esc>p
" JSON.stringify from normal mode, inserted on next line with word your on inside parentheses
nmap clj yiwoclj<Esc>p

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log({});<Esc>==f{a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p
"add new line in insert and normal mode
imap cln console.log('\n\n\n');<Esc>

" fmt.Print from insert mode; Puts focus inside parentheses
imap fpp fmt.Println("")<Esc>==f"a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap fpp yofpp<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap fpp yiwofpp<Esc>p
imap fpn fmt.Println("\n\n\n")<Esc>==f(a


" .............................................................................
" Snippet settings
" .............................................................................
"imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger


" .............................................................................
" Session management
" .............................................................................
"https://dockyard.com/blog/2018/06/01/simple-vim-session-management-part-1
" Helper to make a vim session
exec 'nnoremap <Leader>ss :mksession! ' . '~/vim-sessions' . '/*.vim<C-D><BS><BS><BS><BS><BS>'
" Helper to save a vim session
exec 'nnoremap <Leader>sr :so ' . '~/vim-sessions' . '/*.vim<C-D><BS><BS><BS><BS><BS>'

" .............................................................................
" nvim-Typescript 
" .............................................................................
let g:typescript_indent_disable = 1

" .............................................................................
" ALE / deoplete settings
" .............................................................................
" <TAB>: completion: The default binding for vim popup selection is <c-n> , <c-p> besides arrow key.
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort "{{{
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}

"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ deoplete#manual_complete()

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"call deoplete#custom#option('omni_patterns', {
"\ 'go': '[^. *\t]\.\w*',
"\ })

"set completeopt+=noselect,menuone

"nmap <silent> <leader>aj :ALENext<cr>
"nmap <silent> <leader>ak :ALEPrevious<cr>

"let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
"let g:ale_fix_on_save = 1
"let g:max_list = 20

"let g:ale_fixers = {
"\    'javascript': ['eslint'],
"\    'typescript': ['eslint', 'tslint'],
"\    'json': ['prettier'],
"\}
"let g:ale_linters = {
"\   'javascript': ['eslint'],
"\   'typescript': ['tsserver', 'tslint'],
"\}

"" Find all declarations in this file
"au FileType javascript,typescript nmap gd :TSDef<cr> 
"" Find what this type implements
"au FileType javascript,typescript nmap gp :TSDefPreview<cr> 
"" Finds the callers of this function 
"au FileType javascript,typescript nmap <leader>gc :GoCallers<cr>    
"" Find the _test file for this go file.
"au Filetype javaScript,typescript nmap <leader>ga <Plug>(go-alternate-edit)  

" .............................................................................
" COC settings
" .............................................................................

" Declare CoC extensions // TODO: move all cocsettings into vimrc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint'
  \ ]

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

" Which node version to use for CoC
let g:coc_node_path = '/Users/jfan/.nvm/versions/node/v14.4.0/bin/node'
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

" Use `[c` and `]c` to navigate diagnostics (overlaps with git hunks)
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

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

" .............................................................................
" fugitive mappings - git mappings / rhubarb directory
" .............................................................................

nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gm :Gdiff origin/master<CR>
nmap <Leader>gg :Gstatus<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>fc :GCheckout<CR>
nmap <Leader>fct :GCheckoutTag<CR>

" This lets me push from vim
nnoremap <Leader>gp :Dispatch! git push<CR>


let g:github_enterprise_urls = ['git@git.blendlabs.com:blend'] " this helps me open up the line in github directly from vim
nnoremap <Leader>bb :<C-R>=line('.')<CR>Gbrowse<CR>


" .............................................................................
"  FZF mappings
" .............................................................................
"" See `man fzf-tmux` for available options
" Alternatively, you can make fzf open in a tmux popup window (requires tmux 3.2 or above) by putting fzf-tmux options in tmux key.


"if exists('$TMUX')
  "let g:fzf_layout = { 'tmux': '-p90%,60%' }
"else
  "let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"endif

"let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all' " default fzf options
let g:fzf_history_dir = '~/.local/share/fzf-history' " enable navigating search history using Ctrl-P and Ctrl-N
"Customizable extra key bindings for opening selected files in different ways
"let g:fzf_action
"Determines the size and position of fzf window
"let g:fzf_layout
"Customizes fzf colors to match the current color scheme
"let g:fzf_colors
"let g:fzf_preview_window = '' " disable preview window

"nnoremap <C-p> :GFiles <CR> " Launch fzf with CTRL+P.

" Search all files under git root
nnoremap <C-p> :ProjectFiles <CR> 

" Open buffers
nnoremap <space><space> :Buffers!<CR>

" Open all lines
"nnoremap <Leader>l :Lines<CR>

" searching through files using silver searcher
nmap <Leader>/ :Ag!<CR> 

" Search current word under cursor
nnoremap <silent> <Leader>ag :Ag! <C-R><C-W><CR>
" search current word under cursor
" https://github.com/junegunn/fzf.vim/issues/182
command! -nargs=* AgQ call fzf#vim#ag(<q-args>, {'down': '40%', 'options': '-q '.shellescape(<q-args>.' ')})
"nnoremap <silent> <Leader>ag :AgQ <C-R><C-W><CR>


" .............................................................................
" FZF Commands
" .............................................................................

" :GFiles will only find files committed to the repo. This will find the git
" root and run :Files from the git root
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files!' s:find_git_root()
" Map a few common things to do with FZF.
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" using rip grep to search starting from root of git directory
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \ fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)


" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

" Command tosearch current word under cursor
" https://github.com/junegunn/fzf.vim/issues/182
"command! -nargs=* AgQ call fzf#vim#ag(<q-args>, {'down': '40%', 'options': '-q '.shellescape(<q-args>.' ')})
"nnoremap <silent> <Leader>ag :AgQ <C-R><C-W><CR>


" .............................................................................
" FZF preview Commands :) experimenting
" .............................................................................
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

" Useful
nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatus<CR>

nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]g    :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>

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
nmap <silent> <leader>sa :set nolist!<CR>
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

autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2

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


"set undofile "Maintain undo history between sessions
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

" Debugging configs
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
	  \ }

let g:go_def_mode='godef' " works with vendor! 
"let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"


let g:go_fmt_fail_silently = 1       "disable locatiion list
let g:go_auto_type_info = 1          "Automatically show function signature when moving mouse over valid identifier"
let g:go_def_mapping_enabled = 1     " disable vim-go :GoDef short cut (gd). Let coc handle it? or not?
let g:go_auto_sameids = 0            " Disable automatically highlighting matching identifiers"
"let g:go_autodetect_gopath = 1 " Whether to automatically determine gopath

let g:go_highlight_build_constraints = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1 
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1


" Note: CTRL-T will take you back the definition jumps you made
" Find all declarations in this file
au FileType go nmap <leader>gt :GoDeclsDir<cr> 
" Find what this type implements
au FileType go nmap <leader>gi :GoImplements<cr> 
" Finds the callers of this function 
au FileType go nmap <leader>gc :GoCallers<cr>    
" Find the _test file for this go file.
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)  
"au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
"au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
" Go to where this identifier is defined. Ctrl T will bring you back.
au FileType go nmap gd <Plug>(go-def) 
"let g:go_guru_scope = ["/Users/jfan/go/src/git.blendlabs.com/blend/connectivity/server/..."]


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

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
function! MyLineinfo()
  return line('.') . '/' . line('$')
endfunction
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'gitbranch' , 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'filename': 'LightlineFilename',
      \   'lineinfo': 'MyLineinfo', 
      \   'gitbranch': 'gitbranch#name'
      \ }
      \ }
set statusline^=%{coc#status()}
