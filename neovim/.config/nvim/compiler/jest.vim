let current_compiler = "jest"

CompilerSet makeprg=npx\ jest
CompilerSet errorformat=%+E\ %\\{2}●\ %.%#,
CompilerSet errorformat+=%-C\ %\\{4}%[\ >]%#%\\d%\\+\ %#\|%.%#,
CompilerSet errorformat+=%-C\ %\\{4}\ %#\|%.%#,
CompilerSet errorformat+=%+Z\ %\\{6}at\ Object.%\\S%\\+\ (%f:%l:%c),
CompilerSet errorformat+=%+C\ %\\{4}%.%#,
CompilerSet errorformat+=%+C,
CompilerSet errorformat+=%-C%.%#,
