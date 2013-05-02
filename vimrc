set nocompatible

" Vundle =====================================================================

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundles
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'VimClojure'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vividchalk'
Bundle 'xenoterracide/html.vim'

" General Config =============================================================

set autoread
set backspace=indent,eol,start
set cursorline
set dictionary=/usr/share/dict/words
set encoding=utf-8
set hidden
set history=1000
set laststatus=2
set lazyredraw
set modelines=0
set number
set numberwidth=5
set showcmd
set showmatch
set showmode
set splitbelow
set splitright
set title
set ttyfast
set visualbell

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Search Settings ============================================================

set incsearch
set hlsearch
set ignorecase
set smartcase

" Persistent undo and backups ================================================

if has("persistent_undo")
    set undodir=~/.vim/tmp/undo
    set undoreload=10000
    set undofile
endif

set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

" Indentation and wrapping ===================================================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround

set wrap
set textwidth=78
set formatoptions=qn1
try
    set colorcolumn=+1
catch /Unknown option/
    " old Vim version
endtry

filetype plugin on
filetype indent on

set list listchars=tab:»·,trail:·
set showbreak=↪

" Completion =================================================================

set wildmode=list:longest
set wildmenu

" Colors =====================================================================

syntax on
set background=dark
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    colorscheme solarized
endif

" Scrolling ==================================================================

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Convenience mappings =======================================================

" Make capitals behave
nnoremap D d$
nnoremap Y y$

" It's 2012.
noremap j gj
noremap k gk

" Easy tab navigation
map <S-H> gT
map <S-L> gt

" Substitute
nnoremap <leader>s :%s//<left>

" Clear search highlighting
map <C-l> :nohlsearch<CR>

" Fuck you, help key
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Disable those arrow keys!
inoremap  <Up>     <NOP>
noremap   <Up>     <NOP>
inoremap  <Down>   <NOP>
noremap   <Down>   <NOP>
inoremap  <Left>   <NOP>
noremap   <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Right>  <NOP>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Save as root even if not root
cmap w!! %!sudo tee > /dev/null %

" Close QuickFix window
map <leader>q :cclose<CR>

" Autocommands ===============================================================

if has("autocmd")

  set omnifunc=syntaxcomplete#Complete

  augroup vimrcEx
  au!

  " Remove any trailing whitespace that is in the file
  autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")')) | endif

  " Filetype-specific settings
  autocmd Filetype ruby set tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufRead *.html,*.htm set tabstop=2 shiftwidth=2 softtabstop=2 nowrap
  autocmd BufRead *.txt set tabstop=2 shiftwidth=2 softtabstop=2

  augroup END

endif " has("autocmd")

" Plugin settings ============================================================

" Matchit.vim

runtime macros/matchit.vim

" NERD Tree

map <C-e> :NERDTreeToggle<CR>

let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40

" Supertab

let g:SuperTabLongestHighlight = 1

" Ack

map <leader>a :Ack!<space>

" Powerline

let g:Powerline_symbols = 'fancy'

" CtrlP

let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']

map <C-t> :CtrlPTag<CR>
map <C-b> :CtrlPBuffer<CR>

" Rspec.vim

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" Environments (GUI/Console) =================================================

if has("gui_running")

    if has("gui_gtk2")
        set guifont=Menlo\ for\ Powerline\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ for\ Powerline:h15
    elseif has("gui_win32")
        set guifont=Menlo\ for\ Powerline:h15
    end

    " Remove all the UI cruft
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
    set go-=m

    highlight SpellBad term=underline gui=undercurl guisp=Orange

    set guicursor+=a:blinkon0

    if has("gui_macvim")
        set fuoptions=maxvert
    endif
endif

" Local vimrc ================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
