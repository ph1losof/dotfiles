# Clear inherited TMUX env when not actually inside a tmux pane.
# Ghostty on macOS inherits $TMUX from parent tmux sessions,
# which prevents the tmux.fish plugin autostart from working.
if set -q TMUX
    set -l our_tty (command tty 2>/dev/null)
    set -l tmux_ttys (command tmux list-panes -a -F '#{pane_tty}' 2>/dev/null)
    if not contains -- $our_tty $tmux_ttys
        set -e TMUX
        set -e TMUX_PANE
        set -e fish_tmux_autostarted
    end
end
