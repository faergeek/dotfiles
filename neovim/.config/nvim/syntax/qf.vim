if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "qf"

syntax match Conceal "│"
syntax match Directory ".*:\d\+:\d\+│" contains=CursorLineNr
syntax match CursorLineNr ":\d\+" contained nextgroup=Conceal
syntax match DiagnosticSignError "^ " skipwhite nextgroup=Directory
syntax match DiagnosticSignWarn "^ " skipwhite nextgroup=Directory
syntax match DiagnosticSignInfo "^ " skipwhite nextgroup=Directory
syntax match DiagnosticSignHint "^ " skipwhite nextgroup=Directory

" Hide file name and line number for help outline (TOC).
if get(w:, 'quickfix_title') =~# '\<Table of contents$'
  syntax match Conceal "^.*│" conceal
endif

setlocal conceallevel=3 concealcursor=nvi
