# Clear inherited TMUX env when not actually inside a tmux pane.
# Ghostty on macOS inherits $TMUX from parent tmux sessions,
# which prevents the tmux.fish plugin autostart from working.
if set -q TMUX
    set -l ppid (command ps -o ppid= -p $fish_pid 2>/dev/null | string trim)
    set -l parent (command ps -o comm= -p $ppid 2>/dev/null | string trim)
    if not string match -q 'tmux*' -- $parent
        set -e TMUX
        set -e TMUX_PANE
        set -e fish_tmux_autostarted
    end
end
