# set neovim as an editor and a man pager
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER nvim -c 'Man!' -o -

# asdf
source ~/.asdf/asdf.fish
source ~/.asdf/completions/asdf.fish

# fzf options
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker='*'"

# less
set -gx LESSUTFCHARDEF E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p
set -gx LESS -RF

# opam
source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

# pacdiff
set -gx DIFFPROG 'nvim -d'

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

    # eza
    if type -q eza
        alias ls='eza --icons'
    end
end
