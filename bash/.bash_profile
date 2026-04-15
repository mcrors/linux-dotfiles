# ~/.bash_profile - Login shell configuration
# This file runs once on login. It sets up environment variables and PATH,
# then sources .bashrc for interactive shell settings.
#
# Structure:
#   .bash_profile   -> sets PATH/exports, sources .bashrc
#   .bashrc         -> shell options, prompt, tool integrations
#   .bash_aliases   -> command aliases
#   .bash_functions -> reusable shell functions
#   .bash_local     -> machine-specific config (optional, not in git)

# =============================================================================
# PATH Configuration (with guards to prevent duplicates and missing dirs)
# =============================================================================

# Helper function to add to PATH if directory exists and not already in PATH
_add_to_path() {
    local dir="$1"
    local position="${2:-prepend}"  # prepend or append
    
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
        if [ "$position" = "append" ]; then
            PATH="$PATH:$dir"
        else
            PATH="$dir:$PATH"
        fi
    fi
}

# User bin directories
_add_to_path "$HOME/bin"
_add_to_path "$HOME/.local/bin"

# Language-specific paths
_add_to_path "$HOME/go/bin"                    # Go binaries
_add_to_path "$HOME/.cargo/bin"                # Rust/Cargo binaries
# Note: Neovim is symlinked to /usr/local/bin/nvim by ansible playbook

# =============================================================================
# Environment Variables
# =============================================================================

# Editor preferences (use nvim if available, fallback to vim, then vi)
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
elif command -v vim &>/dev/null; then
    export EDITOR=vim
    export VISUAL=vim
else
    export EDITOR=vi
    export VISUAL=vi
fi

# Terminal (only set if the terminal exists)
if command -v kitty &>/dev/null; then
    export TERMINAL="kitty"
elif command -v alacritty &>/dev/null; then
    export TERMINAL="alacritty"
fi

# Browser (only set if exists)
for browser in google-chrome-stable google-chrome chromium firefox; do
    if command -v "$browser" &>/dev/null; then
        export BROWSER="$(command -v $browser)"
        break
    fi
done

# Neovim runtime (check ansible nightly install location first)
if [ -d "/opt/nvim-nightly/share/nvim/runtime" ]; then
    export VIMRUNTIME="/opt/nvim-nightly/share/nvim/runtime"
elif [ -d "/usr/share/nvim/runtime" ]; then
    export VIMRUNTIME="/usr/share/nvim/runtime"
fi

# Go
if command -v go &>/dev/null || [ -d "$HOME/go" ]; then
    export GOBIN="$HOME/go/bin"
fi

# =============================================================================
# Colored man pages (less)
# =============================================================================
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'

# =============================================================================
# Source .bashrc for interactive shell settings
# =============================================================================
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Clean up helper function
unset -f _add_to_path
