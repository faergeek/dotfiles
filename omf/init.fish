# bobthefish theme settings
set -g theme_display_git_ahead_verbose yes
set -g theme_display_date no
set -g theme_title_display_process yes
set -g theme_display_user yes
set -g default_user faergeek

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
set -gx MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH

# add local node_modules/.bin to PATH
set -gx PATH ./node_modules/.bin $PATH

# yarn global binaries
set -gx PATH (yarn global bin) $PATH

# pkgconfig path for XQuartz
set -gx PKG_CONFIG_PATH /opt/X11/lib/pkgconfig
# pkgconfig path for zlib
set -gx PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH

# opam
eval (opam config env)
