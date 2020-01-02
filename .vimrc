call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'amiorin/vim-project'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'phpactor/phpactor'
Plug 'vim-syntastic/syntastic'
Plug 'phpactor/ncm2-phpactor'
Plug 'tmhedberg/simpylfold'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'nvie/vim-flake8'
Plug 'vim-scripts/indentpython.vim'
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'Valloric/YouCompleteMe'
Plug 'Raimondi/delimitMate'
"Plug 'townk/vim-autoclose'
call plug#end()
set laststatus=2
map <C-n> :NERDTreeToggle<CR>
"Add ctrl + e support to go to end of line
inoremap <C-e> <C-o>A
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \| set softtabstop=4
    \| set shiftwidth=4
    \| set textwidth=79
    \| set expandtab
    \| set autoindent
    \| set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \| set softtabstop=2
    \| set shiftwidth=2
autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Let Python COde Look Prettyyyy
let python_highlight_all=1
syntax on
" Sytastic support
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0 
let g:syntastic_check_on_wq = 0
" Pythoon Exec with F9
nnoremap <buffer> <F9> :exec '!clear;python3' shellescape(@%, 1)<cr>
"Show lie numbers by default
set number
"ADD COLOR SUPPORT FOR VIM LIGHTLINE IN TMUX
if !has('gui_running')
	  set t_Co=256
  endif

" Add flake8 syntax check to syntastic
let g:syntastic_python_checkers=['flake8']
