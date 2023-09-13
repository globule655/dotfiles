execute pathogen#infect()
syntax on
filetype plugin indent on

let g:terraform_fmt_on_save=1

set number
set shiftwidth=2
set tabstop=2     " (ts) width (in spaces) that a <tab> is displayed as
set expandtab     " (et) expand tabs to spaces (use :retab to redo entire file)
set autoindent
set autoread
colorscheme base16-google-dark
set termguicolors

" Remove vim background
hi Normal guibg=NONE ctermbg=NONE

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

set scrolloff=5 " Keep 5 lines below and above the cursor

" Toggle nerdtree view on/off
map <C-n> :NERDTreeToggle<CR>

" Automatically start nerdtree when no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" mu-complete mandatory vim setting
set completeopt+=menuone

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
