setlocal tabstop=2 shiftwidth=2 expandtab
command -bang -buffer LSPEnable call vlime#server#New(v:true, <bang>v:false)

if get(g:, 'add_alexandria_macros_to_lispwords', v:true)
	set lispwords+=if-let,when-let,when-let*,once-only,destructuring-case,named-lambda,nth-value-or,switch,cswitch,eswitch,doplist,with-gensyms,with-unique-names
	let g:add_alexandria_macros_to_lispwords = v:false
endif
