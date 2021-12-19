" Change the setup of Parinfer, which does things I don't want it to do by
" default, such as setting the tab character to indent lines in insert mode

" Removes Parinfer's autocmds
augroup parinfer | autocmd! | augroup END

" Adds the Parinfer autocmds I want to the filetypes I want
augroup parinfer-setup
    autocmd!
    execute 'autocmd FileType ' . join(g:vim_parinfer_filetypes, ',') . ' runtime parinfer_augroup.vim'
augroup end
