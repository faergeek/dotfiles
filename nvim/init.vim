set shell=sh

call plug#begin()

" Session management
Plug 'tpope/vim-obsession'

" Start screen
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
Plug 'mhinz/vim-startify'

" Colorscheme
Plug 'morhetz/gruvbox'

" Status line
set noshowmode
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Comment helpers
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
Plug 'scrooloose/nerdcommenter', {'on': '<plug>NERDCommenterToggle'}

" Surround
Plug 'tpope/vim-surround'

" For repeating plugin mappings
Plug 'tpope/vim-repeat'

" Syntaxes
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'tpope/vim-git'
Plug 'jparise/vim-graphql', {'for': 'graphql'}
let g:javascript_plugin_flow = 1
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'elzr/vim-json', {'for': 'json'}
let g:jsx_ext_required = 0
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'wavded/vim-stylus', {'for': 'stylus'}
Plug 'digitaltoad/vim-pug', {'for': 'pug'}

" Completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#keyword_patterns = {}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'steelsojka/deoplete-flow', {'for': 'javascript'}

" Linting
let g:ale_javascript_eslint_options = '--cache'
let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint', 'flow']
let g:ale_linters.html = []
Plug 'w0rp/ale'

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
let g:gruvbox_italic = 1
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

set completeopt+=menuone,noinsert,noselect
set wildignore=*/node_modules/*,*.min.js

" read per-directory settings
set exrc
set secure

" Restore last cursor position
augroup vimrcEx
  au!

  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Toggle comments
map <C-c> <plug>NERDCommenterToggle

" Next/Previous error from ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Filetype mappings
autocmd BufRead,BufNewFile *.js.flow setfiletype javascript
autocmd BufRead,BufNewFile .babelrc setfiletype json
autocmd BufRead,BufNewFile .flowconfig setfiletype dosini
autocmd BufRead,BufNewFile .sentryclirc setfiletype dosini
