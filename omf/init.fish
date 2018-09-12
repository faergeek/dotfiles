# bobthefish theme settings
set -g theme_display_git_ahead_verbose yes
set -g theme_display_date no
set -g theme_title_display_process yes
set -g theme_show_exit_status yes
set -g theme_newline_cursor yes
set -g theme_display_k8s_context yes

# set nvim as an editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# colors for man pages
set -gx LESS_TERMCAP_mb (printf "\033[01;31m")
set -gx LESS_TERMCAP_md (printf "\033[01;31m")
set -gx LESS_TERMCAP_me (printf "\033[0m")
set -gx LESS_TERMCAP_se (printf "\033[0m")
set -gx LESS_TERMCAP_so (printf "\033[01;44;33m")
set -gx LESS_TERMCAP_ue (printf "\033[0m")
set -gx LESS_TERMCAP_us (printf "\033[01;32m")

# set paths for gnu binaries and man pages
set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

# pkgconfig path for XQuartz
set -gx PKG_CONFIG_PATH /opt/X11/lib/pkgconfig
# pkgconfig path for zlib
set -gx PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH

# set locale
set -gx LANG ru_RU.UTF-8
