execute pathogen#infect()
syntax on
filetype plugin indent on

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
Plug 'ThePrimeagen/harpoon'
Plug 'kshenoy/vim-signature'
call plug#end()

let g:terraform_fmt_on_save=1
let NERDTreeShowHidden=1

set number
set relativenumber
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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
