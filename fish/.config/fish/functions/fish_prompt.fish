function fish_prompt
    if not [ -z "$SSH_CONNECTION" ]
        prompt_login
        printf ":"
    end

    set_color blue
    printf "$(prompt_pwd)"

    set --global --export __fish_git_prompt_color normal
    set --global --export __fish_git_prompt_show_informative_status true
    set --global --export __fish_git_prompt_showcolorhints true
    set --global --export __fish_git_prompt_showdirtystate true
    set --global --export __fish_git_prompt_showstashstate true
    set --global --export __fish_git_prompt_showuntrackedfiles true
    set --global --export __fish_git_prompt_showupstream auto
    fish_vcs_prompt

    printf '\n'

    if jobs -q
        set_color yellow
        printf "󰒓 $(jobs --command) "
    end

    if fish_is_root_user
        set_color red
        printf '#'
    else
        set_color magenta
        printf ''
    end

    set_color normal
    printf ' '
end
