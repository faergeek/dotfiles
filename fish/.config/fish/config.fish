# set neovim as an editor and a man pager
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER nvim +Man!
set -gx MANWIDTH 80

# asdf
if [ -d ~/.asdf ]
    source ~/.asdf/asdf.fish
    source ~/.asdf/completions/asdf.fish
end

# ghcup
set -gx PATH $HOME/.cabal/bin ~/.ghcup/bin $PATH

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
        alias ls='eza --icons'
    end
end
