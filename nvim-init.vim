filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/matchit.zip'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'airblade/vim-gitgutter'
"Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
"Plug 'vim-perl/vim-perl'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
"Plug 'c9s/perlomni.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'w0rp/ale'
Plug 'posva/vim-vue'
"
" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on    " required

let g:ctrlp_follow_symlinks = 1

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Use deoplete.
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:go_fmt_fail_silently = 1
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
set mouse=

au FilterWritePre * if &diff | colorscheme leo | endif

let mapleader = "\<Space>"

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

au BufRead,BufNewFile *.tt setfiletype tt2html
au BufRead,BufNewFile *.tt2 setfiletype tt2html

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
vnoremap <leader>c "*y<CR>
nnoremap <leader>v :set paste!<CR>"*p<CR>:set paste!<CR>

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

nnoremap <leader>b :TagbarToggle<CR>

vmap < <gv
vmap > >gv

let g:NERDCreateDefaultMappings = 0
nnoremap <leader>/ :call NERDComment(0,"toggle")<CR>
vnoremap <leader>/ :call NERDComment(0,"toggle")<CR>

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

" perl linting
let g:ale_perl_perl_options =
\   get(g:, 'ale_perl_perl_options', '-Ilib -Ilocal/lib/perl5 -Mwarnings -Mstrict -c')
