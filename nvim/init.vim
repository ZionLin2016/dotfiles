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

filetype off

call plug#begin('~/.config/nvim/plugged')

" switch ibus input
Plug 'kevinhwang91/vim-ibus-sw'

" navigation
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tweekmonster/fzf-filemru', {'on': 'FilesMru'}
Plug 'junegunn/fzf.vim'

" edit
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'mg979/vim-visual-multi'

" theme
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'  " icons need nerd font

" syntax highlight
Plug 'sheerun/vim-polyglot'

" snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" markdown
Plug 'iamcco/markdown-preview.vim'

" suda, fix neovim ':w !sudo tee %' bug
Plug 'lambdalisue/suda.vim'

" comment
Plug 'scrooloose/nerdcommenter'

" format
Plug 'sbdchd/neoformat'

" language server
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
noremap <silent> <M-1> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25

" fzf
let g:fzf_filemru_bufwrite = 1
noremap <leader>fr :FilesMru --tiebreak=end<CR>
noremap <leader>ff :Files<CR>
noremap <leader>ft :BTags<CR>
noremap <leader>fl :BLines<CR>
noremap <leader>fb :Buffers<CR>
noremap <leader>fc :BCommits<CR>
noremap <leader>fm :Marks<CR>
noremap <M-0> :Windows<CR>

" mundo toggle
noremap <silent> <M-2> :MundoToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline_theme='one'

" nerd commenter
let g:NERDSpaceDelims = 1
map <C-_> <Plug>NERDCommenterToggle

" suda
noremap <leader>:w :w suda://%

" auto format
noremap <C-M-L> :Neoformat<CR>

let g:neoformat_basic_format_trim = 1

" depend on astyle
let g:neoformat_enabled_c = ['astyle']
let g:neoformat_c_astyle = {'exe': 'astyle', 'args': ['--style=java'], 'replace': 1}

" depend on autopep8
let g:neoformat_enable_python = ['autopep8']
let g:neoformat_python_autopep8 = {'exe': 'autopep8', 'replace': 1}

" gitv
let g:Gitv_OpenHorizontal=1

" coc
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

call plug#end()

filetype plugin indent on

" color scheme
colorscheme one
set background=dark
" colorscheme onedark
hi CocHighlightText  guibg=#3e4452
