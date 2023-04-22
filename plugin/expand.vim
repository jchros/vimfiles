call minpac#add('Olical/vim-expand')

func expand#op(type = '') abort
	if empty(a:type)
		set opfunc=expand#op
		return 'g@'
	endif

	'[,']call expand#ExpandRange()
	return ''
endfunc

nnoremap <expr> <Plug>(Expand) expand#op()
xnoremap <Plug>(Expand) :Expand<cr>

nmap yx <Plug>(Expand)
nmap yxx yx_
nmap yxyx yx_
xmap yx <Plug>(Expand)
