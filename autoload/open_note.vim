let open_note#doc_dir = g:vimfiles_dir . '/doc'
func s:can_grep_tags() abort
	return executable('grep') && kkp#file_exists(g:open_note#doc_dir . '/tags')
endfunc

func open_note#cmd_interface(info) abort
	if a:info.bang
		call open_note#in_new_window(a:info.mods, a:info.name, a:info.desc)
	else
		call open_note#(a:info.name, a:info.desc)
	endif
endfunc

func open_note#(name, desc) abort
	if empty(a:name)
		throw 'Note name is missing.'
	endif
	if s:can_grep_tags()
		let tag = systemlist(['grep', '-F', ';' . a:name, g:open_note#doc_dir . '/tags'])
		if !v:shell_error
			let [tag, file, pat] = split(tag[0], "\t")
			let file = join([g:open_note#doc_dir, file], '/')
			let pat = '+' . escape(pat, ' \*$~.[]')
			silent! execute 'keeppatterns edit' pat file
			return
		endif
	endif
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute 'e' newfile
	call open_note#add_header_tag(a:name, a:desc)
endfunc

func open_note#in_new_window(mods, name, desc) abort
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
		return
	endif
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute a:mods 'new' newfile
	call open_note#add_header_tag(a:name, a:desc)
endfunc

func open_note#add_header_tag(tag, desc = v:null)
	let header = '*;' . a:name . '*'
	if !empty(a:desc)
		let header .= ' ' . a:desc
	endif
	call append(0, header)
endfunc

func open_note#complete(arg_lead, cmd_line, cursor_pos) abort
	if !s:can_grep_tags()
		return ''
	endif
	let res = systemlist("grep --only-matching '^;[^\t]*' " . shellescape(g:open_note#doc_dir . '/tags'))
	return join(map(res, 'v:val[1:]'), "\n")
endfunc
