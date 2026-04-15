# ~/.bash_aliases - Command aliases
# All aliases are guarded to only apply when the underlying tool exists

# =============================================================================
# Color Support
# =============================================================================

# Enable color support for ls and grep variants (Linux)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# macOS ls color support
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
fi

# =============================================================================
# LS Aliases
# =============================================================================

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -hal --group-directories-first 2>/dev/null || ls -hal'

# =============================================================================
# Better Tool Replacements (only if installed)
# =============================================================================

# Use ripgrep instead of grep if available
if command -v rg &>/dev/null; then
    alias rg='rg --hidden'
    # Uncomment to replace grep entirely:
    # alias grep='rg'
fi

# Use bat/batcat instead of cat if available
if command -v batcat &>/dev/null; then
    alias cat='batcat'
    alias bat='batcat'
elif command -v bat &>/dev/null; then
    alias cat='bat'
fi

# Use nvim for vimdiff if available
if command -v nvim &>/dev/null; then
    alias vimdiff='nvim -d'
    alias vim='nvim'
    alias vi='nvim'
fi

# =============================================================================
# Clipboard (X11)
# =============================================================================

if command -v xclip &>/dev/null; then
    alias xclip='xclip -selection clipboard'
fi

# =============================================================================
# Notifications
# =============================================================================

# Alert alias for long running commands: sleep 10; alert
if command -v notify-send &>/dev/null; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# =============================================================================
# Git Shortcuts
# =============================================================================

if command -v git &>/dev/null; then
    alias g='git'
    alias gs='git status'
    alias gd='git diff'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git log --oneline -20'
fi

# =============================================================================
# Safety Aliases
# =============================================================================

# Prompt before overwriting
alias cp='cp -i'
alias mv='mv -i'

# =============================================================================
# Convenience
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias path='echo -e ${PATH//:/\\n}'
