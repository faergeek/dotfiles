if status is-interactive
  # used by pacdiff
  set -gx DIFFPROG 'nvim -d'

  set -gx TEALDEER_CONFIG_DIR ~/.config/tealdeer

  # customize the info shown by pfetch
  set -gx PF_INFO "ascii os host kernel shell editor uptime pkgs memory palette"

  if type pfetch 2&> /dev/null
    function fish_greeting
      pfetch
    end
  end

  set -gx EZA_ICON_SPACING 2

  if type eza 2&> /dev/null
    alias ls='eza --icons --git'
  end

  alias less='less -RF'
end
