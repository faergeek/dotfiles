# set neovim as an editor and a man pager
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER nvim +Man!
set -gxp MANPATH $__fish_data_dir/man:
set -gx MANWIDTH 80

# asdf
set -gx ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_installed
add_to_path "$HOME/.asdf/shims"

# bat
set -gx BAT_THEME ansi

# ghcup
add_to_path $HOME/.cabal/bin $HOME/.ghcup/bin

# husky
set -gx HUSKY 0

# lefthook
set -gx LEFTHOOK 0

# less
set -gx PAGER less
set -gx LESSUTFCHARDEF E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p
set -gx LESS -RFS

# luarocks
add_to_path $HOME/.luarocks/bin

# Disable annoying MinIO Client's pager
set -gx MC_DISABLE_PAGER 1

# opam
[ -z "$OPAM_SWITCH_PREFIX" ] && [ -r $HOME/.opam/opam-init/init.fish ] && source $HOME/.opam/opam-init/init.fish

# pnpm
set -gx PNPM_HOME $HOME/.local/share/pnpm
add_to_path "$PNPM_HOME"

# ripgrep
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/args

if status is-interactive
    fish_hybrid_key_bindings
    bind --user -M insert ctrl-n down-or-search
    fish_config theme choose ansi

    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace underscore blink
    set fish_cursor_replace_one $fish_cursor_replace
    set fish_cursor_external $fish_cursor_insert

    if not set -q SSH_AUTH_SOCK
        set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    end

    if type -q eza
        alias ls='eza --icons --hyperlink'
    else
        alias ls='ls --color=auto --hyperlink=auto'
    end
end
