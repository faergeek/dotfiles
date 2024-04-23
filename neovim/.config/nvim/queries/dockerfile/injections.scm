((comment) @injection.content
  (#set! injection.language "comment"))

((shell_command
  (shell_fragment) @injection.content)
  (#set! injection.language "bash")
  ; changes        vvvvvvvvvvvvvvvv
  (#set! injection.include-children))

((run_instruction
  (heredoc_block) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))
