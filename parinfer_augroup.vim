execute 'augroup parinfer_' . bufnr('%')
	autocmd!
	autocmd InsertLeave <buffer> call parinfer#process_form()

	if exists('##TextChangedI')
		autocmd TextChangedI <buffer> call parinfer#process_form_insert()
	endif

	if exists('##TextChanged')
		autocmd TextChanged <buffer> call parinfer#process_form()
	else
		nnoremap <buffer> dd <Cmd>call parinfer#delete_line()<cr>
		nnoremap <buffer> p <Cmd>call parinfer#put_line()<cr>
	endif
execute 'augroup END'
