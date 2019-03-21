syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set clipboard=unnamedplus
set timeout timeoutlen=500
set ignorecase
set smartcase
set updatetime=500
set hidden
set cursorline
set wildmode=list:longest,list:full
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set noshowmode
set foldmethod=syntax
set foldlevelstart=99

" undo
set undofile
set undodir=~/.config/nvim/.undo//
set undolevels=200
set history=200

" no backup
set nobackup
set noswapfile

" true color
if (has("termguicolors"))
    set termguicolors
endif

" map
let mapleader = ' '
noremap q <Nop>
noremap qq :q<CR>
noremap qa :qa<CR>
noremap qz :q!<CR>
noremap qx :qa!<CR>
noremap <silent> qc :ccl<CR>
noremap <leader>w :w<CR>
noremap <leader>wq :wq<CR>
noremap <silent> <leader>l :nohlsearch<CR>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-A> <Home>

call plug#begin('~/.config/nvim/plugged')

" switch ibus input
Plug 'kevinhwang91/vim-ibus-sw'
" --------------------------------------------------------------------------------

" navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
noremap <silent> <M-1> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25

if executable("fzf")
  Plug 'junegunn/fzf.vim'
  let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }
  noremap <leader>fr :History<CR>
  noremap <leader>ff :Files<CR>
  noremap <leader>ft :BTags<CR>
  noremap <leader>fo :Tags<CR>
  noremap <leader>fl :BLines<CR>
  noremap <leader>fb :Buffers<CR>
  noremap <leader>fc :BCommits<CR>
  noremap <leader>fm :Marks<CR>
  noremap <leader>fd :History:<CR>
  noremap <leader>fs :History/<CR>
  noremap <M-0> :Windows<CR>
endif


" edit
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
noremap <silent> <M-2> :MundoToggle<CR>
Plug 'mg979/vim-visual-multi'
" --------------------------------------------------------------------------------


" theme
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline_theme='one'
Plug 'ryanoasis/vim-devicons'  " icons need nerd font
" --------------------------------------------------------------------------------

" syntax highlight
Plug 'sheerun/vim-polyglot'
" --------------------------------------------------------------------------------

" snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" --------------------------------------------------------------------------------

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
let g:Gitv_OpenHorizontal=1
" --------------------------------------------------------------------------------

" markdown
Plug 'iamcco/markdown-preview.vim'
" --------------------------------------------------------------------------------

" suda, fix neovim ':w !sudo tee %' bug
Plug 'lambdalisue/suda.vim'
noremap <leader>:w :w suda://%
" --------------------------------------------------------------------------------

" comment
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
map <C-_> <Plug>NERDCommenterToggle
" --------------------------------------------------------------------------------

" format
Plug 'sbdchd/neoformat'
noremap <C-M-L> :Neoformat<CR>

let g:neoformat_basic_format_trim = 1

" depend on astyle
let g:neoformat_enabled_c = ['astyle']
let g:neoformat_c_astyle = {'exe': 'astyle', 'args': ['--style=java'], 'replace': 1}

" depend on autopep8
let g:neoformat_enable_python = ['autopep8']
let g:neoformat_python_autopep8 = {'exe': 'autopep8', 'replace': 1}
" --------------------------------------------------------------------------------
"
" language server
if !empty(glob(expand("<sfile>:p:h")."/coc.vim"))
  execute "source" expand("<sfile>:p:h")."/coc.vim"
endif
"" --------------------------------------------------------------------------------

call plug#end()

" color scheme
try
  colorscheme one
  set background=dark
catch
endtry
