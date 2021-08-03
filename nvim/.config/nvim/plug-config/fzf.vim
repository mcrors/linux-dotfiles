" positioning and look of the fzf window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

" Which files and directories to seacrch or not
let $FZF_DEFAULT_COMMAND = 'rg --files  --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'


