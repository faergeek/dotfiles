function fish_prompt
    set --local exit_code $status

    if test "$CMD_DURATION" -ge 5000
        set --local second 1000
        set --local minute (math "60 * $second")
        set --local hour (math "60 * $minute")
        set --local day (math "24 * $hour")

        set_color yellow

        printf '󱦟 '

        if [ $CMD_DURATION -ge $day ]
            printf '%sd ' (math --scale=0 "$CMD_DURATION / $day")
        end

        if [ $CMD_DURATION -ge $hour ]
            printf '%sh ' (math --scale=0 "$CMD_DURATION % $day / $hour ")
        end

        if [ $CMD_DURATION -ge $minute ]
            printf '%sm ' (math --scale=0 "$CMD_DURATION % $hour / $minute ")
        end

        printf '%s.' (math --scale=0 "$CMD_DURATION % $minute / $second")
        printf '%ss\n' (math --scale=0 "$CMD_DURATION % $second")
    end

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

    if set --query exit_code; and test "$exit_code" -ne 0
        set_color red
        printf "$exit_code "
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
