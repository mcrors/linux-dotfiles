# ~/.bashrc - Interactive shell configuration
# This file is sourced for interactive non-login shells and by .bash_profile

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# =============================================================================
# Shell Options
# =============================================================================

# History settings
HISTCONTROL=ignoreboth          # Don't store duplicates or lines starting with space
HISTSIZE=1000000
HISTFILESIZE=2000000
shopt -s histappend             # Append to history, don't overwrite

# Shell behavior
shopt -s checkwinsize           # Update LINES/COLUMNS after each command
# shopt -s globstar             # ** matches directories recursively (uncomment if desired)

# =============================================================================
# Terminal Settings
# =============================================================================

# Force 256 color support
export TERM=xterm-256color

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Debian chroot indicator
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# =============================================================================
# Prompt Configuration
# =============================================================================

# Detect color capability
case "$TERM" in
    xterm-kitty|xterm-color|*-256color) color_prompt=yes;;
esac

# Git prompt function (safe wrapper)
_git_ps1_safe() {
    if type __git_ps1 &>/dev/null; then
        __git_ps1
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(_git_ps1_safe)\n$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# =============================================================================
# Source Additional Files
# =============================================================================

# Bash completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Git prompt support (for __git_ps1)
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

# Aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

# Machine-specific config (not in version control)
[ -f ~/.bash_local ] && . ~/.bash_local

# Pure exports (work-specific, if exists)
[ -f ~/.pure_exports ] && . ~/.pure_exports

# =============================================================================
# Tool Integrations (all with guards for portability)
# =============================================================================

# FZF - fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# NVM - Node Version Manager
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Pyenv - Python version manager
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ ":$PATH:" != *":$PYENV_ROOT/bin:"* ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi

# Cargo/Rust environment
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Virtualenvwrapper
if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/venvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
    source ~/.local/bin/virtualenvwrapper.sh
fi

# SDKMAN - Java version manager (must be at end)
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
# Set JAVA_HOME only if SDKMAN is available
[ -d "$SDKMAN_DIR/candidates/java/current" ] && export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"

# Kitty terminal integration
if [ -n "$KITTY_INSTALLATION_DIR" ] && [ -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash" ]; then
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
