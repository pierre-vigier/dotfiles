set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'mattn/emmet-vim'
"Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/matchit.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
"Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
"Bundle 'vim-perl/vim-perl'
Bundle 'majutsushi/tagbar'
"Bundle 'nikvdp/ejs-syntax'
Bundle 'godlygeek/tabular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme pablo
syntax on
filetype plugin indent on
set background=""
set diffopt+=iwhite
set ts=4
set sw=4
set expandtab
set fdm=marker
set autoindent
set softtabstop=4
"backspace everything
set bs=2
set hlsearch
" to see non breaking spaces as well
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

au FilterWritePre * if &diff | colorscheme leo | endif

let mapleader = "\<Space>"

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

au BufRead,BufNewFile *.tt setfiletype tt2html

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

"with multicursor, escape from normal mode does not exit multicursor
let g:multi_cursor_exit_from_insert_mode = 0

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>j ddp
nnoremap <leader>k ddkP
nnoremap <leader>v :set paste!<CR>"*p<CR>:set paste!<CR>

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

nnoremap <leader>b :TagbarToggle<CR>

vmap < <gv
vmap > >gv

set laststatus=2

" remember last position in files
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
endif

" macvim section
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata\ for\ Powerline:h15
   endif
   colorscheme pablo
endif
