let current_compiler = "playwright"

CompilerSet makeprg=npx\ playwright\ test\ $*\ \|\ sed\ -u\ 's/\\x1B\\[[0-9;]\\{1,\\}[A-Za-z]//g'
CompilerSet errorformat=%E%>\ %\\{2}%\\d%\\+)\ [%.%#]\ ›\ %f:%l:%c\ ›\ %m\ ─%#,
CompilerSet errorformat+=%-G%[\ >]%#%\\d%\\+\ %#\|%.%#,
CompilerSet errorformat+=%-G\ %#\|%.%#,
CompilerSet errorformat+=%G\ %#at\ %m\ (%f:%l:%c),
CompilerSet errorformat+=%G\ %#at\ %f:%l:%c,
