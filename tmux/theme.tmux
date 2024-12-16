bg_base="#1f1f1f"
bg_darker="#1a1a1a"
bg_selection="#212121"

fg_bright="#fafafa"
fg_dim="#888888"
fg_dimmer="#727272"

ansi_black="#1a1a1a"
ansi_red="#e56375"
ansi_green="#75b975"
ansi_yellow="#f0b362"
ansi_blue="#79b8ff"
ansi_magenta="#b392f0"
ansi_cyan="#9db1c5"
ansi_white="#888888"

bright_black="#5c5c5c"
bright_red="#ff7a84"
bright_green="#85dc85"
bright_yellow="#ffc966"
bright_blue="#93cbff"
bright_magenta="#c4a9f3"
bright_cyan="#b4c9dd"
bright_white="#fafafa"

black="$bg_base"
dark_gray="$bg_darker"
white="$fg_bright"
gray="$fg_dimmer"
status_gray="$fg_dim"
border_gray="$bg_selection"
active_border="#292929"
blue="$ansi_blue"
red="$ansi_red"

set -g status-style "bg=$black,fg=$status_gray"

set -g window-status-style "bg=$dark_gray,fg=$gray"
set -g window-status-current-style "bg=$blue,fg=$black"
set -g window-status-activity-style "bg=$dark_gray,fg=$red"

set -g pane-border-style "fg=$border_gray"
set -g pane-active-border-style "fg=$active_border"

set -g message-style "bg=$dark_gray,fg=$white"
set -g message-command-style "bg=$dark_gray,fg=$white"

set -g mode-style "bg=$border_gray,fg=$white"

set -g clock-mode-colour $blue

set -g status-left "#[fg=$blue,bold] #S "
set -g status-justify left
set -g status-left-length 100
set -g status-right-length 100

set -g @prefix_highlight_fg $black
set -g @prefix_highlight_bg $ansi_yellow
set -g @prefix_highlight_show_copy_mode "on"
set -g @prefix_highlight_copy_mode_attr "fg=$black,bg=$ansi_yellow,bold"
