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
nnoremap <Plug>(ExpandLine) :Expand<cr>
xnoremap <Plug>(Expand) :Expand<cr>

nmap yx <Plug>(Expand)
nmap yxx <Plug>(ExpandLine)
nmap yxyx <Plug>(ExpandLine)
xmap yx <Plug>(Expand)
