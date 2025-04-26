let current_compiler = "vitest"

CompilerSet makeprg=NO_COLOR=1\ npx\ vitest
CompilerSet errorformat=%E\ FAIL\ \ %\\f%\\+\ >\ %m,
CompilerSet errorformat+=%C,
CompilerSet errorformat+=%C\ ❯\ %f:%l:%c,
CompilerSet errorformat+=%C\ %#%\\d%\\+\|%.%#,
CompilerSet errorformat+=%C\ %#\|\ %#%^,
CompilerSet errorformat+=%Z%>⎯%#[%\\d%#/%\\d%#]⎯%#,
CompilerSet errorformat+=%-G%>\ Test\ Files\ \ %.%#,
CompilerSet errorformat+=%+C%.%#,
