" Settings for the mucomplete plugin.

let g:mucomplete#enable_auto_at_startup = v:true
let g:mucomplete#empty_text = 1

let g:mucomplete#chains = {}
let g:mucomplete#chains.default =<< trim END
	path
	user
	omni
	c-n
	dict
END

inoremap <expr> <right> mucomplete#extend_fwd("\<right>")
inoremap <expr> <left> mucomplete#extend_bwd("\<left>")

packadd vim-mucomplete
