" DEFAULT SETUP

syntax on
set nocompatible
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightred

" Color Fix
if !has('gui_running')
      set t_Co=256
endif

"Lightline config
" Set noshowmode for Lightline duplicate statut
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
" END DEFAULT SETUP

" --------------------------------------------

" VIM PLUG SECTION
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'takac/vim-hardtime'
Plug 'scrooloose/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/simpylfold'
Plug 'nvie/vim-flake8'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" END OF VIM PLUG SECTION

" --------------------------------------------

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

" --------------------------------------------

" CUSTOM KEY MAPPINGS

" Change leader from \ to space
let mapleader = " "
" nnoremap <leader>h :wincmd h<CR>
" nnoremap <leader>j :wincmd j<CR>
" nnoremap <leader>k :wincmd k<CR>
" nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
" map jh to imitate ESC
inoremap jh <Esc>
map <C-n> :NERDTreeToggle<CR>
"Add ctrl + e support to go to end of line
inoremap <C-e> <C-o>A

" --------------------------------------------
" YCM CONFIGURATION
" fun! GoYCM()
nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
" let g:ycm_semantic_triggers = { 'c,python,javascript': ['re!(?=[a-zA-Z_])'],}
" endfun

let g:ycm_autoclose_preview_window_after_completion=1
"-------------------------------------------------
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

"     inoremap <buffer> <silent><expr> <TAB>
"                 \ pumvisible() ? "\<C-cn>" :
"                 \ <SID>check_back_space() ? "\<TAB>" :
"                 \ coc#refresh()

"     inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"     inoremap <buffer> <silent><expr> <C-space> coc#refresh()

"     " GoTo code navigation.
"     nmap <buffer> <leader>gd <Plug>(coc-definition)
"     nmap <buffer> <leader>gy <Plug>(coc-type-definition)
"     nmap <buffer> <leader>gi <Plug>(coc-implementation)
"     nmap <buffer> <leader>gr <Plug>(coc-references)
"     nnoremap <buffer> <leader>cr :CocRestart
" endfun

" fun! TrimWhitespace()
"     let l:save = winsaveview()
"     keeppatterns %s/\s\+$//e
"     call winrestview(l:save)
" endfun

" autocmd BufWritePre * :call TrimWhitespace()
" autocmd FileType typescript :call GoYCM()
" autocmd FileType cpp,cxx,h,hpp,c :call GoCoc()
" LightLine Fix
" set laststatus=2
" --------------------------------------------
" Syntastic Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
" --------------------------------------------
" Python Custom Configuration
let python_highlight_all=1
" Pythoon Exec with F9
nnoremap <buffer> <F9> :exec '!clear;python3' shellescape(@%, 1)<cr>
" I have to figure out why I added these lines at first place
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \| set softtabstop=4
    \| set shiftwidth=4
    \| set textwidth=79
    \| set expandtab
    \| set autoindent
    \| set fileformat=unix
au BufNewFile,BufRead *.js,*.html,*.css
    \  set tabstop=2
    \| set softtabstop=2
    \| set shiftwidth=2

autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
" Enable hardtime plugin
let g:hardtime_default_on = 1
