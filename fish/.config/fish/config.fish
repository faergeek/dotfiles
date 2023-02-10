if status is-interactive
  set -gx TEALDEER_CONFIG_DIR ~/.config/tealdeer

  if type pfetch 2&> /dev/null
    function fish_greeting
      PF_INFO="ascii os shell editor memory uptime palette" pfetch
    end
  end
end
