let s:f = expand('<sfile>:t:r')

func {s:f}#autoload_prefix(path) abort
	let res = substitute(matchstr(fnamemodify(a:path, ':p:r'), '/autoload/\zs.*$'), '/', '#', 'g')
	return empty(res) ? '' : (res . '#')
endfunc
