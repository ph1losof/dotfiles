# Workaround: Clear inherited TMUX env when not actually inside a tmux pane.
#
# On macOS, GUI apps inherit environment from the process that launched them.
# If Ghostty is opened from within a tmux session, every new Ghostty window
# inherits $TMUX and $fish_tmux_autostarted, causing budimanjojo/tmux.fish
# to skip autostart (it thinks it's already inside tmux).
#
# This checks if our TTY is actually a tmux pane. If not, the variables
# were inherited and should be cleared.
#
# Can be removed if either is fixed upstream:
#   - Ghostty sanitizes $TMUX from child environment
#   - budimanjojo/tmux.fish validates $TMUX before skipping autostart
if set -q TMUX
    set -l our_tty (command tty 2>/dev/null)
    set -l tmux_ttys (command tmux list-panes -a -F '#{pane_tty}' 2>/dev/null)
    if not contains -- $our_tty $tmux_ttys
        set -e TMUX
        set -e TMUX_PANE
        set -e fish_tmux_autostarted
    end
end
