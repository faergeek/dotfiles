let current_compiler = "playwright"

CompilerSet makeprg=npx\ playwright\ test\ $*\ \|\ sed\ -u\ 's/\\x1B\\[[0-9;]\\{1,\\}[A-Za-z]//g'
CompilerSet errorformat=%+E\ %\\{2}%\\d%\\+)\ [%.%#]\ ›\ %\\f%\\+:%\\d%\\+:%\\d%\\+\ ›\ %.%#\ ─%#,
CompilerSet errorformat+=%+E\ %\\{4}Retry\ #%\\d%\\+\ ─%#,
CompilerSet errorformat+=%-C\ %\\{4}%[\ >]%#%\\d%\\+\ %#\|%.%#,
CompilerSet errorformat+=%-C\ %\\{4}\ %#\|%.%#,
CompilerSet errorformat+=%+C\ %\\{4}\ %#%o\ %f:%l:%c,
CompilerSet errorformat+=%+C\ %\\{4}%.%#,
CompilerSet errorformat+=%+C,
