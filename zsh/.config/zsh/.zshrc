source $ZDOTDIR/zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Function to get the current git branch
function git_branch {
  git branch 2>/dev/null | grep '\*' | sed 's/* //'
}

# source ~/.git-prompt.sh
# setopt PROMPT_SUBST ;

# Define a custom prompt
PROMPT="%F{yellow}%n@%m%f %F{blue}%~%f $(git_branch)$prompt_newline%F{green}λ%f "
