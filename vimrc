" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

" Vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif  

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

"-- UI stuff --
" Palenight themeing
set background=dark
colorscheme palenight
" italics for my favorite color scheme
let g:palenight_terminal_italics=1
set shortmess=atI                  " Don't show the intro message when starting vim
set title                          " set the terminal title
set ruler                          "show status line
set rulerformat=%10(%l,%c%V%)
set laststatus=2                   "always show status line
set cursorline                     "highlight current line
set number                         "show line numbers
set numberwidth=5
set hlsearch                       "highlight search keywords
set noshowmode                     "Don't show bottom line since i'm using lightline.vim
" show trailing spaces, tabs, and end of lines
set listchars=tab:>-,trail:·,eol:$,nbsp:_
nmap <silent> <leader>s :set nolist!<CR>

" ------------------ MY MAPPINGS -----------------
" Managing window splits
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Open nerdtree
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
" remap escape character to kj
inoremap kj  <ESC>
" Direction of opening windows
set splitbelow
set splitright
" make <tab> jump you to the matching bracket in normal or visual modes
nnoremap <tab> %
vnoremap <tab> %
" easier way to get to beginning end of line
map H ^
map L $

" show trailing spaces, tabs, and end of lines
set listchars=tab:>-,trail:·,eol:$,nbsp:_
nmap <silent> <leader>s :set nolist!<CR>
" toggle line numbers (useful for manual copying code with multiple lines)
map <Leader>r :set invnumber<CR>
" -------------- Spaces and indenting -------------- 
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd BufNewFile,BufRead *.rvt set filetype=tcl
autocmd BufWritePre *.tcl,*.rvt :%s/\s\+$//e

"-- Search --
set incsearch                      "dynamically search term as you type (incremental search)
set ignorecase                     "case-insensitive search
set smartcase                      "unless there's an uppercase letter in the keyword
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif


" No idea what this stuff below does

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif


if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

if &synmaxcol == 3000
  " Lowering this improves performance in files with long lines.
  set synmaxcol=500
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

set autoread

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

"Note: matchit.vim matches if statements, and various other matches. Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

