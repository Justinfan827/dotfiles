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
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" Helpers for unix
Plug 'tpope/vim-eunuch'

"" General
 "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " preview markdown in vim

Plug 'tpope/vim-dispatch' " dispatch async commands in vim (for git push and pull etc)
Plug 'aacunningham/vim-fuzzy-stash' " git stash from vim
Plug 'tpope/vim-fugitive' " git wrapper in vim
"Plug 'tpope/vim-rhubarb' " link to git repo quickly (not workign atm)
Plug 'ruanyl/vim-gh-line' " link to git repo
Plug 'tpope/vim-unimpaired' " nice bindings e.g. '] space' to add empty line, ]l or ]q to move in location / quickfix list
Plug 'christoomey/vim-tmux-navigator' " help navigate with vim / tmux splits
Plug 'airblade/vim-rooter' " Changes vim working directory to the project root (helpful for grepping tools)
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multi line cursors 
Plug 'AndrewRadev/splitjoin.vim' " split structs in golang with gS, gJ
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets' " go snippets
Plug 'qpkorr/vim-bufkill' " kill buffer with :BD without killing session
Plug 'tpope/vim-obsession'
Plug 'vim-utils/vim-husk' " navigate vim command line better 

" Theme and styling
Plug 'skielbasa/vim-material-monokai' 
Plug 'junegunn/goyo.vim' " focus mode
Plug 'junegunn/limelight.vim' " hyperfocus writing in vim
Plug 'fatih/molokai'
Plug 'sainnhe/gruvbox-material'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch' " add git branch to your lightline
Plug 'josa42/vim-lightline-coc' "lightline coc
Plug 'drewtempelmeyer/palenight.vim'
Plug 'scrooloose/nerdtree'  " NERDTree directory tree
Plug 'scrooloose/nerdcommenter' " Key binding to comment out stuff

"" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC: Intellisense engine 
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'

"" Extensions for different languages 
Plug 'gabrielelana/vim-markdown', { 'for': ['markdown'] }
Plug 'hail2u/vim-css3-syntax'
Plug 'posva/vim-vue'
Plug 'HerringtonDarkholme/yats.vim' " syntax highlighting
Plug 'pangloss/vim-javascript' " syntax highlighting
Plug 'leafgarland/typescript-vim' " ts-extension
Plug 'peitalin/vim-jsx-typescript' " TSX language extension
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }


"" Quoting/parenthesizing Note: i'm using coc pairs to run pair closing
Plug 'tpope/vim-surround' " amazing pugin to surround stuff
Plug 'tpope/vim-repeat' " Allow vim to repeat commands from vim-surround!
Plug 'tpope/vim-endwise' " This is a simple plugin that helps to end certain structures automatically. 
Plug 'jiangmiao/auto-pairs' " auto close brackets


" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
call plug#end()

" .............................................................................
" .............................................................................
" Basic setup
" .............................................................................

set undodir=~/.vim/undodir

" Auto read buffers while inside vim
" https://vi.stackexchange.com/questions/444/how-do-i-reload-the-current-file/13092#13092
au FocusGained,BufEnter * :checktime


" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

"......................... Basic UI stuff configs ...........................
syntax on " set this off if i get lag
set lazyredraw
set ttyfast " always set in neovim
set shell=/bin/sh
set shortmess=atI                  " Don't show the intro message when starting vim
set title                          " Set the terminal title
set ruler                          " Show cursor position
set relativenumber                 " Show relative line number
set rulerformat=%10(%l,%c%V%)
set laststatus=2                   " Always show status line
"set cursorline                     " Highlight current line
set number                         " Show line numbers
set numberwidth=5
set hlsearch                       " Highlight search keywords
set noshowmode                     " Don't show bottom line since i'm using lightline.vim
set nowrap


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

" .............................................................................
" .............................................................................
" BASIC MAPPINGS
" .............................................................................
" .............................................................................

" copy the directory of the current buffer to clipboard
nnoremap <Leader>c :let @+=expand('%:p')<CR>

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
noremap <leader>ov :vs ~/.config/nvim/init.vim<CR>
noremap <leader>oz :vs ~/.zshrc<CR>
noremap <leader>oc :vs ~/.config/nvim/coc-settings.json<CR>
noremap <leader>ot :vs ~/.tmux.conf<CR>
noremap <leader>og :vs ~/.gitconfig<CR>
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
imap clj console.log(JSON.stringify(,null, 2))<Esc>==f,i
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
imap fpp fmt.Println()<Esc>==f(a
imap fpq fmt.Println("")<Esc>==f"a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap fpp yofpp<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap fpp yiwofpp<Esc>p
imap fpn fmt.Printf("\n\n\n")<Esc>==f(a



" .............................................................................
" .............................................................................
" UI SETTINGS
" .............................................................................
" .............................................................................

" ......................... theming configs ...........................
" Set terminal colors
if has('termguicolors')
  set termguicolors
  " italics: https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set t_Co=256 " 256 colors in vim

" ......................... Gruvbox configs ...........................
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 1
"let g:gruvbox_material_disable_italic_comment = 1
set background=dark " Use gruvbox dark

"let g:palenight_terminal_italics=1 "

" Theme selection 
colorscheme gruvbox-material      " Note: this should be placed after all theming configs
"colorscheme palenight              " Note: this should be placed after all configs


" nvim setting
let g:python3_host_prog = "/usr/local/bin/python3"
let g:python_host_prog = "/usr/bin/python"
let g:node_host_prog = "/Users/justin/.nvm/versions/node/v16.8.0/bin/node"  
" Which node version to use for CoC
let g:coc_node_path = "/Users/justin/.nvm/versions/node/v16.8.0/bin/node"   " if changing this, remember to change npm.binPath as well: 


" ......................... GitGutter configs ...........................
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

"............. GOYO distraction free mode ....................................................
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!
let g:goyo_width = "500"
let g:goyo_height = "100%"
nnoremap <space>go :Goyo<CR>
nnoremap <space>gc :Goyo!<CR>

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

" Typescript / JS setup
" Sometimes syntax highlighting can get out of sync in large JSX and TSX files. This was happening too often for me so I opted to enable syntax sync fromstart, which forces vim to rescan the entire buffer when highlighting. This does so at a performance cost, especially for large files. It is significantly faster in Neovim than in vim.
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd BufWritePost  *.ts :CocCommand tslint.fixAllProblems
autocmd BufWritePost  *.md :CocCommand markdownlint.fixAll

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
set shiftwidth=4                            " '>' indents with 3 spaces
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
" Snippet settings
" .............................................................................
"
" Type the “snippet trigger” (listed below in the 1st column) and press TAB in insert mode to evaluate the snippet block.
"Use Ctrl + j to jump forward within the snippet
"Use Ctrl + k to jump backward within the snippet.
"Use Ctrl + l to list all the snippets available for the current file-type
"
" Use <C-l> for trigger snippet expand.
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
"let g:typescript_indent_disable = 1

" .............................................................................
" vim-obsession settings
" .............................................................................

" close floats when existing insert mode
nmap <leader>ob :Obsession ~/vim-sessions/Session.vim <CR>
nmap <leader>no :Obsession! <CR>

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

" .............................................................................
" fugitive mappings - git mappings / rhubarb directory
" .............................................................................

nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gm :Gdiff origin/master<CR>
nmap <Leader>gg :Git<CR>
nmap <Leader>gw :Gwrite<CR><CR>
nmap <Leader>gr :Gread<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>fct :GCheckoutTag<CR>


" fugitive git bindings
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gl :silent! Git log<CR>
"nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>go :Git checkout<Space>

" This lets me push from vim
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" This lets me open git branches from vim  git fzf checkout extension
nnoremap <leader>fb :GBranches<CR>

" This lets me open git branches from vim  git fzf checkout extension
nnoremap <leader>gss :GStash<space>
nnoremap <leader>gsl :GStashList<CR>

let g:github_enterprise_urls = ['git@git.blendlabs.com:blend'] " this helps me open up the line in github directly from vim
"https://github.com/vim/vim/issues/4738 temporary fix
if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;()]*')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif

"nnoremap <Leader>bb :<C-R>=line('.')<CR>Gbrowse<CR>
"nnoremap <Leader>bc :<C-R>=line('.')<CR>Gbrowse!<CR>
let g:gh_line_map = '<leader>bg'
let g:gh_line_blame_map_default = 0

let g:gh_github_domain = 'git@git.blendlabs.com:blend'



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
nnoremap <Leader>l :Lines<CR>

" searching through files using silver searcher
nmap <Leader>/ :Ag!<CR> 

" Search current word under cursor
nnoremap <silent> <Leader>ag :Ag! <C-R><C-W><CR>

"
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
" ultisnips configs
" .............................................................................
" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = ",<tab>"
"let g:UltiSnipsJumpForwardTrigger = ",<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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
  let g:go_gopls_options = ['-remote=auto']

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

" .............................................................................
" NERDTree configs
" .............................................................................
" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>ne g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore = ['^node_modules$'] " ignore node_modules to increase load speed 
let g:NERDTreeStatusline = '' " set to empty to use lightline
" " Toggle
noremap <silent> <C-b> :NERDTreeToggle<CR>
" " Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Map to open current file in NERDTree and set size
nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>

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
      \   'left': [ 
      \             [ 'mode', 'paste' ],
      \             [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \             ['cocstatus', 'currentfunction', 'readonly', 'filename', 'gitbranch' , 'modified', 'obsessionstatus'] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'filename': 'LightlineFilename',
      \   'lineinfo': 'MyLineinfo', 
      \   'gitbranch': 'gitbranch#name',
      \   'obsessionstatus': 'ObsessionStatus'
      \ }
      \ }

" register compoments for lightline coc
call lightline#coc#register()


filetype plugin on
