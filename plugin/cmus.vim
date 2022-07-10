if !executable('cmus')
	finish
endif

func s:open_new_cmus_buffer(mods, ...) abort
	if has('nvim')
		execute a:mods 'new term://cmus'
	else
		let args = get(a:, 1, '')
		execute a:mods 'ter ++close' args 'cmus'
	endif
endfunc

func s:cmus(mods) abort
	" We add the [:-2] to strip the new line character at the end
	let pid = system('pgrep cmus')[:-2]
	if v:shell_error
		" cmus isn't running
		return s:open_new_cmus_buffer(a:mods)
	endif
	try
		if has('nvim')
			execute a:mods 'sb term://*/' . pid . ':cmus'
		else
			execute a:mods 'sb !cmus'
		endif
	catch /^Vim\%((\a\+)\)\=:E94:/
		echoerr "cmus isn't running in this " . (has('nvim') ? 'Neovim' : 'Vim') . ' instance'
	endtry
endfunc

let s:nargs = has('nvim') ? '' : '-nargs=*'
execute 'command -bar' s:nargs 'Cmus call <SID>cmus("<mods>")'

if executable('cmus-remote')
	nnoremap <leader>c <Cmd>call system('cmus-remote -u')<cr>
	nnoremap <leader>C <Cmd>call system('cmus-remote -C toggle\ continue')<cr>
	if !has('nvim')
		tnoremap <C-W><leader>c <Cmd>call system('cmus-remote -u')<cr>
		tnoremap <C-W><leader>C <Cmd>call system('cmus-remote -C toggle\ continue')<cr>
	endif
endif
