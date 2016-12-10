set shell=sh

call plug#begin()

" File tree
Plug 'scrooloose/nerdtree'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

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

" Git
Plug 'tpope/vim-fugitive'

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

" Host for plugins written in node
Plug 'neovim/node-host', {'do': 'UpdateRemotePlugins'}

" Rainbow parens
Plug 'kien/rainbow_parentheses.vim'

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
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

" Clojure stuff
Plug 'tpope/vim-fireplace', {'for': 'clojure'}

Plug 'clojure-vim/nvim-parinfer.js', {
      \'do': 'UpdateRemotePlugins',
      \'for': 'clojure'
      \}

" Completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#keyword_patterns = {}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'steelsojka/deoplete-flow', {'for': 'javascript'}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
Plug 'clojure-vim/async-clj-omni', {'for': 'clojure'}

" Linting
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint', 'flow']
Plug 'w0rp/ale'

call plug#end()

" OCaml-related things
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/ocp-indent/vim"

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

" Next three snippets of code were taken from deoplete docs with slight
" variation for Shift+Tab. I have no idea how to refactor this, so it's just
" duplicated. Sorry...

" 1.
" Cycling completions on Tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" 2.
" Cycling completions in reverse order on Shift+Tab
inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" 3.
" Don't just close completion popup on enter, but also
" insert caret return
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" Filetype mappings
autocmd BufRead,BufNewFile *.js.flow setfiletype javascript
autocmd BufRead,BufNewFile .babelrc setfiletype json
autocmd BufRead,BufNewFile .flowconfig setfiletype dosini
autocmd BufRead,BufNewFile .sentryclirc setfiletype dosini
autocmd BufRead,BufNewFile *.eliom setfiletype ocaml

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
