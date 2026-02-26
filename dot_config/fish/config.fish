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
set -x DENO_INSTALL /Users/tentacles/.deno
set -x PATH $DENO_INSTALL/bin:$PATH

# bun
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH

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
    tv init fish | source
    # tv binds ctrl-r to its own history; rebind to atuin's
    bind --mode default ctrl-r _atuin_search
    bind --mode insert ctrl-r _atuin_search
    set fish_tmux_autostart true
end

# Added by Antigravity
fish_add_path /Users/tentacles/.antigravity/antigravity/bin
