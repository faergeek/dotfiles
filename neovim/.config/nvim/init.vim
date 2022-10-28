" Searching
set ignorecase " ignore case on search
set smartcase " only ignore case if entering lower-case
set gdefault " /g flag in search/replace by default

" Indentation
set shiftwidth=2
set softtabstop=2
set expandtab

colorscheme peachpuff

" Always write to file without renaming stuff
" otherwise breaks webpack watch and similar things
set backupcopy=yes

set completeopt+=menuone,noinsert,noselect

" Restore last cursor position
augroup vimrcEx
  au!

  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
