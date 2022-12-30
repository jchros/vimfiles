" Settings for the mucomplete plugin.

let g:mucomplete#enable_auto_at_startup = v:true
let g:mucomplete#empty_text = 1

let g:mucomplete#chains = {}
let g:mucomplete#chains.default =<< trim END
	path
	user
	vsnip
	omni
	c-n
	dict
END

" See mucomplete-tips
let g:mucomplete#can_complete = #{
	"\ omnicompletion is slow with rhubarb
	\ gitcommit: #{omni: { _ -> g:mucomplete_with_key }}
\}

inoremap <expr> <right> mucomplete#extend_fwd("\<right>")
inoremap <expr> <left> mucomplete#extend_bwd("\<left>")

packadd vim-mucomplete
