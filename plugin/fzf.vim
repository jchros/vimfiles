" Some commands leveraging FZF

func s:fzf_location() abort
	if !executable('brew')
		return ''
	endif
	let res = systemlist('brew --prefix fzf')[0]
	return v:shell_error ? '' : res
endfunc

if !empty(s:fzf_location())
	let &runtimepath .= ',' . s:fzf_location()
else
	call minpac#add('junegunn/fzf', {-> fzf#install()})
endif

func s:fzf(dict) abort
	return fzf#run(fzf#wrap(a:dict))
endfunc

if executable('mdfind')
	" Use Spotlight to look up files
	command! -nargs=+ -bar Mdfind call s:fzf(#{source: 'mdfind ' . <q-args>})
endif
