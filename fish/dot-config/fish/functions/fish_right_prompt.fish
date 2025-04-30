function fish_right_prompt
    set --local exit_code $status

    if set --query exit_code; and test "$exit_code" -ne 0
        set_color red
        printf "󰈆 $exit_code"
    end

    if test "$CMD_DURATION" -ge 5000
        set --local second 1000
        set --local minute (math "60 * $second")
        set --local hour (math "60 * $minute")
        set --local day (math "24 * $hour")

        set_color yellow

        printf ' 󱦟 '

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
end
