function fish_greeting
    if type -q pfetch
        PF_INFO="ascii os host kernel shell editor uptime pkgs memory palette" pfetch
    end
end
