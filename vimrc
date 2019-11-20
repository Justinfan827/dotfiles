scriptencoding utf-8
set encoding=utf-8
" Vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif  

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'fcpg/vim-osc52'
" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
call plug#end()
" Automatically install plugins on open
autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

" --------------------- Functionality stuff -----------------------
" where to search for tags
set tags+=./tags;
set tags+=/vhosts/fan/fa_web/tags
filetype plugin on
" change directory to open buffer?
set autochdir
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
" italics for my favorite color scheme
set shortmess=atI                  " Don't show the intro message when starting vim
set title                          " set the terminal title
set ruler                          "show status line
set relativenumber
set rulerformat=%10(%l,%c%V%)
set laststatus=2                   "always show status line
set cursorline                     "highlight current line
set number                         "show line numbers
set numberwidth=5
set hlsearch                       "highlight search keywords
set noshowmode                     "Don't show bottom line since i'm using lightline.vim
let g:lightline = {
	  \ 'active': {
	  \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
	  \ }
	  \ }
" -------------------------- MY MAPPINGS ---------------------------------
" Managing window splits
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
" Open nerdtree
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
" Copy using yank to system keyboard (WIP not working at the moment)
xmap <leader> y:call SendViaOSC52(getreg('"'))<cr>

" show trailing spaces, tabs, and end of lines
set listchars=tab:>-,trail:·,eol:$,nbsp:_
nmap <silent> <leader>s :set nolist!<CR>
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
" Press return to get out of highlighted search
nnoremap <CR> :nohlsearch<CR><CR>
" Use vim grepper to search
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
" ------------------------ Spaces and indenting --------------------------- 
" Allow scroll in vim  
set ttymouse=xterm2
set mouse=a
" Use :help 'option' to see the documentation for the given option.
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd BufNewFile,BufRead *.rvt, *.test set filetype=tcl
autocmd BufWritePre *.tcl,*.rvt :%s/\s\+$//e
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

"-- Search --
set incsearch                      "dynamically search term as you type (incremental search)
set ignorecase                     "case-insensitive search
set smartcase                      "unless there's an uppercase letter in the keyword
"  Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" ^^ isn't working? Trying this instead
nnoremap <Leader><space> :noh<cr>

" No idea what this stuff below does

"if has('autocmd')
  "filetype plugin indent on
"endif
"if has('syntax') && !exists('g:syntax_on')
  "syntax enable
"endif


"if exists('g:loaded_sensible') || &compatible
  "finish
"else
  "let g:loaded_sensible = 'yes'
"endif

"set nrformats-=octal

"if !has('nvim') && &ttimeoutlen == -1
  "set ttimeout
  "set ttimeoutlen=100
"endif

"if &synmaxcol == 3000
  "" Lowering this improves performance in files with long lines.
  "set synmaxcol=500
"endif

set laststatus=2
set wildmenu

"Have an extra line on top and below when scrolling
if !&scrolloff
  set scrolloff=1
endif
"if !&sidescrolloff
  "set sidescrolloff=5
"endif
"set display+=lastline

"if &encoding ==# 'latin1' && has('gui_running')
  "set encoding=utf-8
"endif

"if v:version > 703 || v:version == 703 && has("patch541")
  "set formatoptions+=j " Delete comment character when joining commented lines
"endif

"if has('path_extra')
  "setglobal tags-=./tags tags-=./tags; tags^=./tags;
"endif

"if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  "set shell=/usr/bin/env\ bash
"endif

"set autoread

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
