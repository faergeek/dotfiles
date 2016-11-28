set shell=sh

call plug#begin()

" File tree
Plug 'scrooloose/nerdtree'

" Start screen + session-management
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_skiplist = ['COMMIT_EDITMSG']
Plug 'mhinz/vim-startify'

" Colorscheme
let g:gruvbox_italic = 1
Plug 'morhetz/gruvbox'

" Status line
set noshowmode
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline'

" Git
Plug 'tpope/vim-fugitive'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
let g:flow#enable = 0 " Use some more generic thing for this
Plug 'flowtype/vim-flow', {'for': 'javascript'}

" Comment helpers
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
Plug 'scrooloose/nerdcommenter', {'on': '<plug>NERDCommenterToggle'}

" Surround
Plug 'tpope/vim-surround'

" Linting
let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_linters = {
      \ 'javascript': ['eslint', 'flow'],
      \}

Plug 'w0rp/ale'

" Syntaxes
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'tpope/vim-git'
Plug 'jparise/vim-graphql', {'for': 'graphql'}
Plug 'othree/html5.vim', {'for': 'html'}
let g:javascript_plugin_flow = 1
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'elzr/vim-json', {'for': 'json'}
let g:jsx_ext_required = 0
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'jrk/vim-ocaml', {'for': 'ocaml'}
Plug 'wavded/vim-stylus', {'for': 'stylus'}

call plug#end()

" Searching
set ignorecase " ignore case on search
set smartcase " only ignore case if entering lower-case
set gdefault " /g flag in search/replace by default

" Indentation
set shiftwidth=2
set softtabstop=2
set expandtab

if has("termguicolors") " Enable TrueColor support
  set termguicolors
endif

set background=dark
let g:gruvbox_contrast_dark = "soft"
colorscheme gruvbox

" Highlight cursor line
set cursorline
" Show line numbers
set number numberwidth=4
" Show whitespaces
set list listchars=tab:»\ ,trail:·,nbsp:+
" Always write to file without renaming stuff
" otherwise breaks webpack watch and similar things
set backupcopy=yes

" Restore last cursor position
augroup vimrcEx
  au!

  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Change cursor between block (normal mode) and line (insert mode)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Toggle NERDTree
noremap <backspace> :NERDTreeToggle<CR>
" Reveal in NERDTree
noremap <leader>f :NERDTreeFind<CR>

" Toggle comments
map <C-c> <plug>NERDCommenterToggle

" Next/Previous error from ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Filetype mappings
autocmd BufRead,BufNewFile *.js.flow setfiletype javascript
autocmd BufRead,BufNewFile .babelrc setfiletype json
autocmd BufRead,BufNewFile .flowconfig setfiletype dosini
