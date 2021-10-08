autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre * :%s/\s\+$//e

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

aug polybar_config_ft_detection
    au!
    au BufNewFile,BufRead ~/.config/polybar/config set filetype=dosini
aug end
