let open_note#doc_dir = g:vimfiles_dir . '/doc'
const s:can_grep_tags = executable('grep') && kkp#file_exists(g:open_note#doc_dir . '/tags')

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
	if s:can_grep_tags
		let tag = systemlist(['grep', '-F', ';' . a:name, g:open_note#doc_dir . '/tags'])
		if !empty(tag)
			let [tag, file] = split(tag[0], "\t")[0:1]
			let file = join([g:open_note#doc_dir, file], '/')
			execute 'keeppatterns edit +/\\*' . tag . '\\*' file
			return
		endif
	endif
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute 'e' newfile
	let header = '*;' . a:name . '*'
	if !empty(a:desc)
		let header .= ' ' . a:desc
	endif
	call append(0, header)
endfunc

func open_note#in_new_window(mods, name, desc) abort
	if empty(a:name)
		throw 'Note a:name is missing.'
	endif
	try
		execute a:mods 'help ;' . a:name
		Writeable
	catch /^Vim\%((\a\+)\)\=:E149:/
	endtry
	let newfile = join([g:open_note#doc_dir, a:name . '.txt'], '/')
	execute a:mods 'new' newfile
	let header = '*;' . a:name . '*'
	if !empty(a:desc)
		let header .= ' ' . a:desc
	endif
	call append(0, header)
endfunc

if s:can_grep_tags
	func open_note#complete(arg_lead, cmd_line, cursor_pos) abort
		let res = systemlist("grep --only-matching '^;[^\t]*' " . shellescape(g:open_note#doc_dir . '/tags'))
		return join(map(res, 'v:val[1:]'), "\n")
	endfunc
else
	func open_note#complete(arg_lead, cmd_line, cursor_pos)
		return ''
	endfunc
endif
