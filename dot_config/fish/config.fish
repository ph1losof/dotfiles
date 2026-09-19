# Regular env section ---------------------------------------------------------

# Created by `pipx` on 2025-06-01 16:30:29
set PATH $PATH /Users/tentacles/.local/bin

if test -n "$SSH_CONNECTION"
  set -gx EDITOR 'vim'
else
  set -gx EDITOR 'nvim'
end

set -gx LANG en_US.UTF-8


# Third-party env section -----------------------------------------------------

# Homebrew setup credits to https://github.com/tmwatchanan
if test -d /home/linuxbrew/.linuxbrew # Linux
	set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else if test -d /opt/homebrew # MacOS
	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

# deno
# NOTE: use fish_add_path (idempotent + deduping). The old form
# `set -x PATH $DENO_INSTALL/bin:$PATH` exported PATH and re-prepended on every
# nested shell (tmux panes/subshells), exploding PATH to 1000+ entries and
# slowing `mise hook-env` (runs every prompt) from ~8ms to 300ms+.
set -gx DENO_INSTALL /Users/tentacles/.deno
fish_add_path -gP $DENO_INSTALL/bin

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path -gP $BUN_INSTALL/bin

# RIP command trashbin location
set -x GRAVEYARD /Users/tentacles/.Trash

# Lazygit config location
set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"

# Keybinds section ------------------------------------------------------------

# trigger autocompletion on Control-Y (neovim style)
bind \cy forward-char


# Init section ----------------------------------------------------------------

# Mise activation
mise activate fish | source

# Starship prompt init with transience
function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

# Is interactive part
if status is-interactive
    atuin init fish | source
    # Disable Atuin AI '?' keybind so `??` can be typed normally
    bind "?" self-insert
    if bind -M insert >/dev/null 2>&1
        bind -M insert "?" self-insert
    end
    if bind -M default >/dev/null 2>&1
        bind -M default "?" self-insert
    end
    tv init fish | source
    # tv binds ctrl-r to its own history; rebind to atuin's
    bind --mode default ctrl-r _atuin_search
    bind --mode insert ctrl-r _atuin_search
    set fish_tmux_autostart true
end

# Added by Radicle.
fish_add_path -gaP /Users/tentacles/.radicle/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# kimi-code
fish_add_path -g "/Users/tentacles/.kimi-code/bin"

# strix
fish_add_path /Users/tentacles/.strix/bin

# Mercury shell integration ---------------------------------------------------

# Emits authenticated OSC 133 prompt boundaries so the Mercury daemon can grant
# speculative local echo — the thing that makes typing feel local over a link.
# Without it the daemon has only bracketed-paste plus the kernel's view of the
# PTY, and under tmux that view describes tmux, not this shell.
#
# Must stay LAST in this file: the snippet wraps `fish_prompt`, so it has to run
# after starship has defined it. That is also why it cannot live in conf.d,
# which fish sources *before* config.fish.
mercury shell-integration fish | source
