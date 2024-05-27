if exists("b:current_syntax")
  finish
endif

syn case ignore

syn region qfItem start="^[^:]\+:\d\+\:\d\+" end="$" keepend oneline contains=qfFileName
syn match qfFileName "^[^:]\+" contained nextgroup=qfLineNr
syn match qfLineNr ":\d\+\:\d\+" contained nextgroup=qfSeparator
syn match qfSeparator "\s\+│ " contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError "\(e\|error\) .*$" contained
syn match qfWarning "\(w\|warning\) .*$" contained
syn match qfInfo "\(i\|info\) .*$" contained
syn match qfNote "\(n\|h\) .*$" contained

" Hide file name and line number for help outline (TOC).
if has_key(w:, 'qf_toc') || get(w:, 'quickfix_title') =~# '\<TOC$'
  setlocal conceallevel=3 concealcursor=nc
  syn match Ignore "^[^│]\+│ " conceal
endif

hi def link qfSeparator Delimiter
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn
hi def link qfInfo DiagnosticInfo
hi def link qfNote DiagnosticHint

let b:current_syntax = "qf"
