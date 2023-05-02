if status is-interactive
  set -gx TEALDEER_CONFIG_DIR ~/.config/tealdeer
  set -gx PF_INFO "ascii os host kernel shell editor uptime pkgs memory palette"

  if type pfetch 2&> /dev/null
    function fish_greeting
      pfetch
    end
  end

  if type gpgconf 2&> /dev/null
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end

  set -gx EXA_ICON_SPACING 2

  if type exa 2&> /dev/null
    alias ls='exa --icons --git'
  end
end
