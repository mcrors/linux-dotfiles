source $ZDOTDIR/zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Function to get the current git branch
function git_branch {
    git branch 2>/dev/null | grep '\*' | sed 's/* \(.*\)/(\1)/'
}

# source ~/.git-prompt.sh
setopt PROMPT_SUBST
setopt prompt_subst

# Define a custom prompt
PROMPT="%F{yellow}%n@%m%f %F{blue}%~%f \$(git_branch) $prompt_newline%F{green}λ%f "

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
