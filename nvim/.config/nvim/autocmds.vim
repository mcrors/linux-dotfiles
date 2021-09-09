autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd BufWritePre *.py :%s/\s\+$//e
