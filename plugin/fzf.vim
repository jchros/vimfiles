" Some commands leveraging FZF

func s:fzf(dict) abort
	return fzf#run(fzf#wrap(a:dict))
endfunc

if executable('mdfind')
	" Use Spotlight to look up files
	command! -nargs=+ -bar Mdfind call s:fzf(#{source: 'mdfind ' . <q-args>})
endif
