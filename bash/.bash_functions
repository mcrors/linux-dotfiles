# ~/.bash_functions - Reusable shell functions
# These are separated from .bashrc for better organization

# =============================================================================
# Directory Navigation
# =============================================================================

# Create a directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Go up N directories
up() {
    local d=""
    local limit="${1:-1}"
    for ((i=1; i<=limit; i++)); do
        d="../$d"
    done
    cd "$d" || return 1
}

# =============================================================================
# File Operations
# =============================================================================

# Extract various archive formats
extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <archive>"
        return 1
    fi
    if [ ! -f "$1" ]; then
        echo "'$1' is not a valid file"
        return 1
    fi
    
    case "$1" in
        *.tar.bz2)   tar xjf "$1"    ;;
        *.tar.gz)    tar xzf "$1"    ;;
        *.tar.xz)    tar xJf "$1"    ;;
        *.bz2)       bunzip2 "$1"    ;;
        *.rar)       unrar x "$1"    ;;
        *.gz)        gunzip "$1"     ;;
        *.tar)       tar xf "$1"     ;;
        *.tbz2)      tar xjf "$1"    ;;
        *.tgz)       tar xzf "$1"    ;;
        *.zip)       unzip "$1"      ;;
        *.Z)         uncompress "$1" ;;
        *.7z)        7z x "$1"       ;;
        *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
}

# =============================================================================
# Development Helpers
# =============================================================================

# Find a file by name
ff() {
    find . -type f -iname "*$1*" 2>/dev/null
}

# Find a directory by name
fd() {
    find . -type d -iname "*$1*" 2>/dev/null
}

# Grep history
hg() {
    history | grep "$1"
}

# =============================================================================
# Git Helpers
# =============================================================================

# Show git branch in a clean format
git_branch() {
    git branch 2>/dev/null | grep '^*' | sed 's/* //'
}

# =============================================================================
# Work-Specific Functions
# These are kept here as examples - move to .bash_local if needed
# =============================================================================

# tlog - Navigate to Jenkins tlog directories
# Usage:
#   tlog                                        - Go to /tlogs base directory
#   tlog http://jenkins.example.com/job/name/77/ - Go to specific job run
#
# Requires /tlogs to be mounted (work-specific)
tlog() {
    local TLOG_DIR="/tlogs"
    
    # Check if tlogs directory exists
    if [ ! -d "$TLOG_DIR" ]; then
        echo "Warning: $TLOG_DIR does not exist or is not mounted"
        return 1
    fi
    
    if [ -z "$1" ]; then
        cd "$TLOG_DIR" || return 1
        return 0
    fi
    
    # Parse Jenkins URL
    local url="$1"
    local jenkins_host job_name run_number
    
    # Extract components from URL like: http://repjenkins.dev.example.com:8080/job/my-job/77/
    jenkins_host=$(echo "$url" | sed -n 's|.*://\([^.:]*\).*|\1|p')
    job_name=$(echo "$url" | sed -n 's|.*/job/\([^/]*\)/.*|\1|p')
    run_number=$(echo "$url" | sed -n 's|.*/job/[^/]*/\([0-9]*\).*|\1|p')
    
    if [ -z "$jenkins_host" ] || [ -z "$job_name" ] || [ -z "$run_number" ]; then
        echo "ERROR: Could not parse URL. Expected format:"
        echo "  http://jenkins.example.com/job/job-name/123/"
        return 1
    fi
    
    local dest="$TLOG_DIR/$jenkins_host/jobs/$job_name/$run_number"
    echo "cd $dest"
    cd "$dest" || return 1
}
