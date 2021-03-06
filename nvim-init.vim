filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'kaicataldo/material.vim'
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
"Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'posva/vim-vue'
"Plug 'chrisbra/csv.vim'
Plug 'w0rp/ale'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/neocomplcache.vim'
Plug 'fisadev/vim-isort'
Plug 'vim-scripts/dbext.vim'
" Python and other languages code checker
"Plug 'scrooloose/syntastic'
if has('python')
    " YAPF formatter for Python
    Plug 'pignacio/vim-yapf-format'
endif
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
"Plug 'vim-scripts/indentpython.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'
"Plug 'davidhalter/jedi-vim'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2'
" Fast python completion (use ncm2 if you want type info or snippet support)
"Plug 'HansPinckaers/ncm2-jedi'
" Words in buffer completion
"Plug 'ncm2/ncm2-bufword'
" Filepath completion
"Plug 'ncm2/ncm2-path'
"
" Add plugins to &runtimepath
call plug#end()
filetype plugin indent on

" airline settings
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
  "let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

" neovim specific settings
if has('nvim')
    " Set the Python binaries neovim is using. Please note that you will need to
    " install the neovim package for these binaries separately like this for
    " example:
    " pip3.6 install -U neovim
    let g:python_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
    "let g:node_host_prog = '/usr/local/bin/node'
    "let g:coc_node_path = '/usr/local/bin/node'
endif

" Convenient move across windows
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set foldmethod=marker
set autoindent
"backspace everything
set bs=2
set hlsearch
" to see non breaking spaces as well
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
set mouse=
set number
set relativenumber
set ruler

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set colorcolumn=81                " highlight the 80th column as an indicator
let g:material_theme_style = 'dark'
let g:material_terminal_italics = 1
let g:airline_theme = 'material'
colorscheme material
if (has("termguicolors"))
  set termguicolors
endif

"Leader to my liking
let mapleader = "\<Space>"

" Highlight useless spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" syntax highlighting for template toolkit in perl
au BufRead,BufNewFile *.tt setfiletype tt2html
au BufRead,BufNewFile *.tt2 setfiletype tt2html

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

"remove empty end of line spaces
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

" shortcuts
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>j ddp
nnoremap <leader>k ddkP
vnoremap <leader>c "*y<CR>
nnoremap <leader>v :set paste!<CR>"*p<CR>:set paste!<CR>

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

nnoremap <leader>b :TagbarToggle<CR>

nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

vmap < <gv
vmap > >gv

" NERDCommenter options
let g:NERDCreateDefaultMappings = 0
nnoremap <leader>/ :call NERDComment(0,"toggle")<CR>
vnoremap <leader>/ :call NERDComment(0,"toggle")<CR>

" remember last position in files
set laststatus=2

" Launch gopls when Go files are in use
"let g:LanguageClient_serverCommands = {
       "\ 'go': ['gopls']
       "\ }
" Run gofmt and goimports on save
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
""inoremap <silent><expr> <c-space> coc#refresh()

"" Use `[c` and `]c` to navigate diagnostics
""nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use U to show documentation in preview window
"nnoremap <silent> U :call <SID>show_documentation()<CR>

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "snake_case"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_auto_type_info = 1
set updatetime=400
let g:go_auto_type_info = 1

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

" perl linting
let g:ale_perl_perl_options =
\   get(g:, 'ale_perl_perl_options', '-Ilib -Ilocal/lib/perl5 -Mwarnings -Mstrict -c')

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Syntastic ------------------------------

" show list of errors and warnings on the current file
"nmap <leader>e :Errors<CR>
" check also when just opened the file
"let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
"let g:syntastic_enable_signs = 0
"let g:syntastic_enable_perl_checker = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'

" Jedi-vim ------------------------------

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>


" Use deoplete.
let g:deoplete#enable_at_startup = 1

" NeoComplCache ------------------------------

" most of them not documented because I'm not sure how they work
" (docs aren't good, had to do a lot of trial and error to make 
" it play nice)
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_ignore_case = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_enable_fuzzy_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_fuzzy_completion_start_length = 3
"let g:neocomplcache_auto_completion_start_length = 3
"let g:neocomplcache_manual_completion_start_length = 3
"let g:neocomplcache_min_keyword_length = 3
"let g:neocomplcache_min_syntax_length = 3
"" complete with workds from any opened file
"let g:neocomplcache_same_filetype_lists = {}
"let g:neocomplcache_same_filetype_lists._ = '_'
