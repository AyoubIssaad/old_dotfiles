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
" Wed Aug 25 2021 22:35
" ---------------------------------------------------
"
" SETUP FOLDS {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"  BASIC CONFIGS {{{
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
set backspace=indent,eol,start
" set clipboard=unnamed,unnamedplus
filetype plugin indent on
" Allows you to switch between buffers without saving EVERY TIME:
set hidden
" }}}

" PLUGINS {{{
call plug#begin('~/.vim/plugged')
 Plug 'tpope/vim-sensible'
 Plug 'scrooloose/nerdtree'
 Plug 'unblevable/quick-scope'
 " Plug 'jremmen/vim-ripgrep' # enable this when plugin updated
 Plug 'gruvbox-community/gruvbox'
 Plug 'tpope/vim-fugitive'
 Plug 'vim-utils/vim-man'
 Plug 'mbbill/undotree'
 Plug 'itchyny/lightline.vim'
 Plug 'tpope/vim-commentary'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'tpope/vim-surround'
 Plug 'Raimondi/delimitMate'
 Plug 'tmhedberg/simpylfold'
 " Plug 'nvie/vim-flake8'
 Plug 'Yggdroot/indentLine'
 " Plug 'vim-syntastic/syntastic'
 Plug 'tmux-plugins/vim-tmux'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'Vimjas/vim-python-pep8-indent'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'mattn/emmet-vim'
 " Plug 'overcache/NeoSolarized'
" -------------
" Plug 'junegunn/vim-peekaboo'
" Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'mhinz/vim-signify'
call plug#end()
" }}}

" AESTHETICS {{{

if !has('gui_running')
      set t_Co=256
endif

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Fix some colors on Alacritty, 24 bit support

colorscheme gruvbox
set background=dark

" For these lines to take effect they must come after the call of Gruvbox
" ctermbg=lightgrey
" highlight ColorColumn guibg=lightblue

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

" CUSTOM MAPPINGS & SHORTCUT {{{

let mapleader = " "
" Easy pasting and yanking
noremap <leader>y "+y
noremap <leader>po "+p
" put current time
nnoremap <leader>sd :put =strftime('%a %b %d %Y %H:%M')<CR>
" leader*2 to switch between buffers
nnoremap <leader><leader> <c-^>
" Switch between buffers using left and right arrows
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" Naviguate using fzf
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

" Formatting selected code.
xmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" }}}

" PLUGINS CONFIGURATION {{{

" Emmet
" Change <c-y>, to ,,
" let g:user_emmet_leader_key='<C-Z>'
imap ,, <C-y>,
" Enable Emmet for html & css only
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" RipGrip

 if executable('rg')
     let g:rg_derive_root='true'
 endif
" FZF With RIPGREP

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Indentline
let g:indentLine_fileTypeExclude = ['markdown','json']
" let g:indentLine_setConceal = 0

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'OldHope',
      \ }

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers=['pylint']

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" " Flake8
" autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>

" Coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" }}}

" AUTO COMMANDS {{{

" Remove trailing white space at save
autocmd  BufWritePre * %s/\s\+$//e

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" FIX COLON INDENT IN YAML FILE
au FileType yaml setlocal indentkeys-=<:>
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

" TEMPORARY SETTINGS {{{

" Disable arrow keys
" nnoremap <Left> :echo "No left for you!"<CR>
" vnoremap <Left> :<C-u>echo "No left for you!"<CR>
" inoremap <Left> <C-o>:echo "No left for you!"<CR>
" nnoremap <Right> :echo "No right for you!"<CR>
" vnoremap <Right> :<C-u>echo "No right for you!"<CR>
" inoremap <Right> <C-o>:echo "No right for you!"<CR>
" nnoremap <Up> :echo "No up for you!"<CR>
" vnoremap <Up> :<C-u>echo "No up for you!"<CR>
" inoremap <Up> <C-o>:echo "No up for you!"<CR>
" nnoremap <Down> :echo "No down for you!"<CR>
" vnoremap <Down> :<C-u>echo "No down for you!"<CR>
" inoremap <Down> <C-o>:echo "No down for you!"<CR>
" " }}}
