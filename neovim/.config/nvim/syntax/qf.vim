if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "qf"

syntax match Directory "^.*│" contains=CursorLineNr,Conceal,DiagnosticError,DiagnosticWarn,DiagnosticInfo,DiagnosticHint
syntax match CursorLineNr ":\d\+\s*" contained
syntax match Conceal "│" nextgroup=DiagnosticError,DiagnosticWarn,DiagnosticInfo,DiagnosticHint
syntax match DiagnosticError " .*" contains=Conceal
syntax match DiagnosticWarn " .*" contains=Conceal
syntax match DiagnosticInfo " .*" contains=Conceal
syntax match DiagnosticHint " .*" contains=Conceal
syntax match Conceal "\e\[\d\{1,2}m" conceal

" Hide file name and line number for help outline (TOC).
if get(w:, 'quickfix_title') =~# '\<Table of contents$'
  syntax match Conceal ".*:\d\+." conceal
endif

setlocal conceallevel=3 concealcursor=nc
