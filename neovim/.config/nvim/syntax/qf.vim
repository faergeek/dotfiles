if exists("b:current_syntax")
  finish
endif

syn case ignore

syn match qfFileName "^[^┃]*" nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft "┃" contained nextgroup=qfLineNr
syn match qfLineNr "\s*\(\d\+\:\d\+\)\?\s*" contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight "┃" contained nextgroup=qfError,qfWarning
syn match qfError "  .*$" contained
syn match qfWarning "  .*$" contained

" Hide file name and line number for help outline (TOC).
if get(w:, 'quickfix_title') =~# '\<Table of contents$'
  setlocal conceallevel=3 concealcursor=nc
  syn match Ignore "^[^┃]*┃[^┃]*┃   " conceal
endif

hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn

let b:current_syntax = "qf"
