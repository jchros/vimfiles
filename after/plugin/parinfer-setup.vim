" Change the setup of Parinfer, which does things I don't want it to do by
" default, such as setting the tab character to indent lines in insert mode

" Check if parinfer exists
if !has('g:vim_parinfer_filetypes')
	finish
endif

command -nargs=+ ParinferAutocmd execute 'autocmd FileType' join(g:vim_parinfer_filetypes, ',') <q-args>

" Adds the Parinfer autocmds I want to the filetypes I want
augroup parinfer
    autocmd!
    ParinferAutocmd autocmd InsertLeave <buffer> call parinfer#process_form()
    if exists('##TextChangedI')
        ParinferAutocmd autocmd TextChangedI <buffer> call parinfer#process_form_insert()
    endif

    if exists('##TextChanged')
        ParinferAutocmd autocmd TextChanged <buffer> call parinfer#process_form()
    else
        ParinferAutocmd nnoremap <buffer> dd <Cmd>call parinfer#delete_line()<cr>
        ParinferAutocmd nnoremap <buffer> p <Cmd>call parinfer#put_line()<cr>
    endif
augroup end

delcommand ParinferAutocmd
