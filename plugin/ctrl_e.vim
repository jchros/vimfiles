fun s:unmatched(...) abort
	let line = get(a:, 1, getline('.'))
	let closers = {'[': ']', '{': '}', '(': ')', '"': '"'}
	let lisps = ['clojure', 'racket', 'lisp', 'scheme', 'lfe', 'fennel']
	if index(lisps, &ft) == -1
		let closers["'"] = "'"
	endif
	let [context, in_quote] = [[], v:false]
	for c in map(range(strlen(substitute(line, '[(\[{]\+\s*$', '', ''))), 'line[v:val]')
		if in_quote
			if context[0] == '\'
				" Ignore escape character
				call remove(context, 0)
			elseif c == '\'
				" Escape sequence
				call insert(context, '\')
			elseif c == context[0]
				let [context, in_quote] = [context[1:], v:false]
			endif
		elseif has_key(closers, c)
			" More nesting!
			let in_quote = closers[c] == c
			call insert(context, closers[c])
		elseif c == get(context, 0, '')
			call remove(context, 0)
		endif
	endfor
	return get(context, 0, ";\<c-g>u")
endfun

inoremap <expr> <c-e> getcurpos()[2] == col('$') ? <sid>unmatched() : '<end>'
