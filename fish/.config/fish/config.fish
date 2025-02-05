# set neovim as an editor and a man pager
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER nvim +Man!
set -gx MANPATH $__fish_data_dir/man $MANPATH
set -gx MANWIDTH 80

# asdf
set -gx ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_installed

# ghcup
set -gx PATH $HOME/.cabal/bin ~/.ghcup/bin $PATH

# Turn off git hooks bullshit.
# https://www.youtube.com/watch?v=LL01pLjcR5s
#
# husky
# https://typicode.github.io/husky/how-to.html#skipping-git-hooks
set -gx HUSKY 0
# lefthook
# https://lefthook.dev/usage/env.html
set -gx LEFTHOOK 0

# less
set -gx PAGER less
set -gx LESSUTFCHARDEF E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p
set -gx LESS -RFS

# opam
if [ -d ~/.opam ]
    source ~/.opam/opam-init/init.fish
end

# pacdiff
set -gx DIFFPROG 'nvim -d'

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm

if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# tealdeer
set -gx TEALDEER_CONFIG_DIR ~/.config/tealdeer

if status is-interactive
    fish_hybrid_key_bindings
    fish_config theme choose "Catppuccin Frappe"

    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace underscore blink
    set fish_cursor_replace_one $fish_cursor_replace
    set fish_cursor_external $fish_cursor_insert

    set -gx GPG_TTY (tty)

    if not set -q SSH_AUTH_SOCK
        set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    end

    if type -q eza
        alias ls='eza --icons --hyperlink'
    else
        alias ls='ls --color=auto --hyperlink=auto'
    end
end
