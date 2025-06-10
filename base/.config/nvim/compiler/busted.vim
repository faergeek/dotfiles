let current_compiler = "busted"

CompilerSet makeprg=busted
CompilerSet errorformat=%+EFailure\ ->\ %\\f%\\+\ @\ %\\d%\\+,
CompilerSet errorformat+=%+EError\ ->\ %\\f%\\+\ @\ %\\d%\\+,
CompilerSet errorformat+=%C%f:%l:\ %m
CompilerSet errorformat+=%+C%.%#,
CompilerSet errorformat+=%Z,
