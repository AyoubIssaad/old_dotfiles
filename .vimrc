" __________    __________
" \______   \   \______   \
"  |    |  _/    |     ___/
"  |    |   \    |    |
"  |______  / /\ |____|
"         \/  \/
" ---------------------------------------------------
" A.I (BinaryPax) => Vim custom configuration file
" Vim Plug as plugin manager
" Don't forget to create the undodir at ~/.vim/undodir
" ---------------------------------------------------
"
" setup folds {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" ---------------------------------------------------
" Basic Configs
" ---------------------------------------------------

"  basic configs {{{
syntax on
set noerrorbells
set encoding=utf-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set ignorecase
set colorcolumn=80
set smartcase
set cursorline
set spell spelllang=en_us
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
set cursorcolumn
set scrolloff=8
set pastetoggle=<F2>
set clipboard=unnamed,unnamedplus
filetype plugin indent on
" }}}

" ---------------------------------------------------
" Plugins (Vim Plug)
" ---------------------------------------------------

" plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
" Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
"Plug 'ycm-core/YouCompleteMe'
Plug 'jremmen/vim-ripgrep'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/simpylfold'
Plug 'nvie/vim-flake8'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'mhinz/vim-signify'
call plug#end()
" }}}

" ---------------------------------------------------
" Aesthetics
" ---------------------------------------------------

" Aesthetics {{{
if !has('gui_running')
      set t_Co=256
endif

colorscheme gruvbox
set background=dark

" For these lines to take effect they must come after the call of Gruvbox
" ctermbg=lightgrey
highlight ColorColumn guibg=lightblue
" Transparency
hi Normal guibg=NONE ctermbg=NONE
" When enabling transparency (line above), underline for spell check is lost,
" the following line brings it back
hi clear SpellBad
hi SpellBad cterm=underline

" Netrw

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
" }}}

" ---------------------------------------------------
" Custom Mappings & Shortcuts
" ---------------------------------------------------

" mappings {{{
let mapleader = " "

nnoremap <silent> <leader>z :Files<CR>

" Fix spelling errors with <leader>f & toggle spell check with <leader>s
nnoremap <leader>f 1z=
nnoremap <leader>s :set spell!<cr>

" use jh instead of ESC to leave insert mode
inoremap jh <Esc>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" C-e to go to end of line in Insert mode
inoremap <C-e> <C-o>A

" Execute Python3 with <F9>
nnoremap <buffer> <F9> :exec '!clear;python3' shellescape(@%, 1)<cr>

" Open terminal below
noremap <leader>t :below terminal<CR>
" }}}

" --------------------------------------------
" Plugins Configuration
" --------------------------------------------

" plugins configuration {{{
" RipGrip

 if executable('rg')
     let g:rg_derive_root='true'
 endif

" Indentline
let g:indentLine_fileTypeExclude = ['markdown','json']
" let g:indentLine_setConceal = 0

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['pylint']

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" " Flake8
" autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
" }}}

" --------------------------------------------
" Auto Commands
" --------------------------------------------
" auto commands {{{
" Remove trailing white space at save
autocmd  BufWritePre * %s/\s\+$//e

" ---------------------------------------------------
" Settings per file type
" ---------------------------------------------------
au BufNewFile,BufRead *.py
    \| set textwidth=79
    \| set fileformat=unix
    \| let python_highlight_all=1
au BufNewFile,BufRead *.js,*.html,*.css
    \  set tabstop=2
    \| set softtabstop=2
    \| set shiftwidth=2
" }}}

" ---------------------------------------------------
" Temporary settings
" ---------------------------------------------------

" temporary settings {{{
" Disable arrow keys
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>
" }}}
