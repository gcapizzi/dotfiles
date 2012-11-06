" Preamble --------------------------------------------------------------------

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vividchalk'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'sjl/gundo.vim'
Bundle 'mileszs/ack.vim'
Bundle 'kana/vim-textobj-function'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-line'
Bundle 'kana/vim-textobj-user'
Bundle 'VimClojure'
Bundle 'matchit.zip'

filetype plugin indent on

" Basic options ---------------------------------------------------------------

set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set dictionary=/usr/share/dict/words
set encoding=utf-8
set history=1000
set laststatus=2
set lazyredraw
set list listchars=tab:»·,trail:·
set modelines=0
set number
set numberwidth=5
set ruler
set shiftround
set showbreak=↪
set showcmd
set showmode
set splitbelow
set splitright
set title
set ttyfast
set visualbell

" Wildmenu completion
set wildmenu
set wildmode=list:longest

" Color scheme
syntax on
set background=dark
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    colorscheme solarized
endif

" Tabs, spaces, wrapping
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=78
set formatoptions=qn1
try
    set colorcolumn=+1
catch /Unknown option/
    " old Vim version
endtry

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Backups
if has("persistent_undo")
    set undofile
    set undoreload=10000
    set undodir=~/.vim/tmp/undo//
endif
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

" Searching and movement ------------------------------------------------------

set ignorecase
set smartcase
set incsearch
set hlsearch

runtime macros/matchit.vim

" Make capitals behave
nnoremap D d$
nnoremap Y y$

" It's 2011.
noremap j gj
noremap k gk

" Easy buffer navigation
noremap <C-h>     <C-w>h
noremap <C-j>     <C-w>j
noremap <C-k>     <C-w>k
noremap <C-l>     <C-w>l
noremap <leader>v <C-w>v

" Disable those arrow keys!
inoremap  <Up>     <NOP>
noremap   <Up>     <NOP>
inoremap  <Down>   <NOP>
noremap   <Down>   <NOP>
inoremap  <Left>   <NOP>
noremap   <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Right>  <NOP>

" Convenience mappings --------------------------------------------------------

" Substitute
nnoremap <leader>s :%s//<left>

" Formatting, TextMate-style
nnoremap Q gqip

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Toggle search highlighting
map <Leader>h :set invhls <CR>

" Fuck you, help key
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Autocommands ----------------------------------------------------------------

if has("autocmd")

  set omnifunc=syntaxcomplete#Complete

  augroup vimrcEx
  au!

  " Remove any trailing whitespace that is in the file
  autocmd BufWrite * if ! &bin | :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")')) | endif

  " Filetype-specific settings
  autocmd Filetype ruby set tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype php set tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufRead *.html,*.htm set tabstop=2 shiftwidth=2 softtabstop=2 nowrap
  autocmd BufRead *.txt set tabstop=2 shiftwidth=2 softtabstop=2

  augroup END

endif " has("autocmd")

" Plugin settings -------------------------------------------------------------

" NERD Tree

map <Leader>n :NERDTreeToggle<cr>

au Filetype nerdtree setlocal nolist

let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40

" Supertab

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestHighlight = 1

" Ack

map <leader>a :Ack!<space>

" Powerline

let g:Powerline_symbols = 'fancy'

" CtrlP

let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']

map <C-t> :CtrlPTag<CR>

" Environments (GUI/Console) --------------------------------------------------

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
