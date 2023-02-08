if status is-interactive
  if type pfetch 2&> /dev/null
    function fish_greeting
      PF_INFO="ascii os shell editor memory uptime palette" pfetch
    end
  end
end
