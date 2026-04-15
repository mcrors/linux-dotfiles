# ~/.fzf.bash - FZF configuration for Bash
# Setup fzf
# ---------
# If installed via apt/package manager, the PATH addition is not required
# Uncomment if you installed fzf manually:
# if [[ ! "$PATH" == *"$HOME/.fzf/bin"* ]]; then
#     export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
# fi

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
    # Try different locations where fzf completion might be
    if [ -f "$HOME/.config/fzf/completion.bash" ]; then
        source "$HOME/.config/fzf/completion.bash"
    elif [ -f /usr/share/bash-completion/completions/fzf ]; then
        source /usr/share/bash-completion/completions/fzf
    elif [ -f /usr/share/fzf/completion.bash ]; then
        source /usr/share/fzf/completion.bash
    fi
fi

# Key bindings
# ------------
if [ -f "$HOME/.config/fzf/key-bindings.bash" ]; then
    source "$HOME/.config/fzf/key-bindings.bash"
elif [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# Custom key bindings for bash (using bind, not bindkey which is zsh)
# Alt+r for history search, Alt+t for file search
# These are set by key-bindings.bash but you can customize here:
# bind '"\er": "\C-r"'  # Example: Alt+r triggers Ctrl+r
