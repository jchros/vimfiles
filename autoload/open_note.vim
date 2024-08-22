let open_note#doc_dir = g:vimfiles_dir . '/doc'
func s:can_grep_tags() abort
	return executable('grep') && !empty(glob(g:open_note#doc_dir . '/tags'))
endfunc

func! open_note#cmd_interface(info) abort
	if a:info.bang
		call open_note#in_new_window(a:info.mods, a:info.name, a:info.desc)
	else
		call open_note#(a:info.name, a:info.desc)
	endif
endfunc

func! open_note#(name, desc) abort
	if empty(a:name)
		throw 'Note name is missing.'
	endif
	if s:can_grep_tags()
		let tag = systemlist('grep -F ' . shellescape(';' . a:name) . ' ' . g:open_note#doc_dir . '/tags')
		if !v:shell_error
			let [tag, file, pat] = split(tag[0], "\t")
			let file = join([g:open_note#doc_dir, file], '/')
			let pat = '+' . escape(pat, ' \*$~.[]')
			silent! execute 'keeppatterns edit' pat file
			silent! doautocmd User OpenedNote
			return
		endif
	endif
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute 'e' newfile
	call open_note#add_header_tag(a:name, a:desc)
	silent! doautocmd User OpenedNote
endfunc

func! open_note#in_new_window(mods, name, desc) abort
	if empty(a:name)
		throw 'Note a:name is missing.'
	endif
	let could_open = v:false
	try
		execute a:mods 'help ;' . a:name
		Writeable
		let could_open = v:true
	catch /^Vim\%((\a\+)\)\=:E149:/
	endtry
	if could_open
		autocmd ModifiedSet <buffer> ++once set buftype=
		silent! doautocmd User OpenedNote
		return
	endif
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute a:mods 'new' newfile
	call open_note#add_header_tag(a:name, a:desc)
	silent! doautocmd User OpenedNote
endfunc

func! open_note#add_header_tag(tag, desc = v:null)
	let header = '*;' . a:tag . '*'
	if !empty(a:desc)
		let header .= ' ' . a:desc
	endif
	call append(0, header)
endfunc

func! open_note#complete(arg_lead, cmd_line, cursor_pos) abort
	const [cmd_name, cmd_name_start, arg_begin] = matchstrpos(a:cmd_line, '\vO%[penNote]!?\s*;?')
	if a:cursor_pos < arg_begin
		return []
	endif
	const [tag, tag_begin, tag_end] = matchstrpos(a:cmd_line, '[#-)!+-~]\+', arg_begin)
	if a:cursor_pos > tag_end
		return []
	endif
	return getcompletion(';' .. tag, 'help')->map({k, v -> v[1:]})
endfunc
