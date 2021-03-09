# bobthefish theme settings
set -g theme_display_git_ahead_verbose yes
set -g theme_display_date no
set -g theme_title_display_process yes
set -g theme_show_exit_status yes
set -g theme_newline_cursor yes
set -g theme_display_k8s_context yes
set -g theme_display_node yes

# set nvim as an editor
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -gx PATH ~/Library/Android/sdk/platform-tools $PATH
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
