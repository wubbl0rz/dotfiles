" =====> general settings <=====================================================
set omnifunc=syntaxcomplete#Complete
set scrolloff=1
set scrolljump=5
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab
set number         
set nofoldenable  
scriptencoding utf-8
set cursorline          
set nowrap             
set ignorecase
set smartcase
set mouse=   
syntax on   
set noswapfile
set hlsearch
set incsearch
"set timeoutlen=1000 ttimeoutlen=0
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=0
"set cmdheight=5

" =====> undo <=================================================================
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" =====> remember last position <===============================================
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" =====> change cursor in insert <============================================== 
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

