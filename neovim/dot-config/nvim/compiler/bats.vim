let current_compiler = "bats"

CompilerSet makeprg=bats\ %
CompilerSet errorformat=%Enot\ ok\ %\\d%\\+\ %m,
CompilerSet errorformat+=%C#\ (%.%#,
CompilerSet errorformat+=%C#\ \ in\ test\ file\ %f\\,\ line\ %l),
CompilerSet errorformat+=%C#,
CompilerSet errorformat+=%C#\ %m,
