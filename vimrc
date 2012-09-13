
" Preamble --------------------------------------------------------------------

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
filetype off
filetype plugin indent on
set nocompatible

" Basic options ---------------------------------------------------------------

set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set dictionary=/usr/share/dict/words
set encoding=utf-8
" set hidden
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
if has("+relativenumber")
    set relativenumber
endif

" Wildmenu completion
set wildmenu
set wildmode=list:longest
" set wildmode=full

" Color scheme
syntax on
set background=dark
colorscheme solarized
set t_Co=16 " make VIM look like GVim with Solarized colors!

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

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

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

" Faster Esc
inoremap jk <esc>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Toggle search highlighting
map <Leader>h :set invhls <CR>

" Fuck you, help key
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Autocommands ----------------------------------------------------------------

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

if has("autocmd")

  set omnifunc=syntaxcomplete#Complete

  augroup vimrcEx
  au!

  " Remove any trailing whitespace that is in the file
  autocmd BufWrite * if ! &bin | :call <SID>StripTrailingWhitespaces() | endif

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

" Taglist

let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1

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
