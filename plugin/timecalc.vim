let s:pat = '\v(\d+)%(:([0-5]\d))?:([0-5]\d)'
let s:alt_pat = '\v^(-)?' . s:pat[2 :] . '$'

let s:cpo_save = &cpo
set cpo&vim

func s:secs_to_dur(d) abort
	let d = a:d
	let [s, d] = [d % 60, d / 60]
	let [m, d] = [d % 60, d / 60]
	let h = d

	return h != 0
	\	? printf("%d:%02d:%02d", h, m, s)
	\	: printf("%d:%02d", m, s)
endfunc

func SumDurations(durations) abort
	let total = 0

	for duration in a:durations
		if type(duration) == type('')
			" Parse duration
			let matches = duration->matchlist(s:alt_pat)
			if !empty(matches)
				let [sign, h, m, s] = matches[1 : 4]
				if empty(m)
					let [h, m] = [0, h]
				endif
				let duration = (h * 60 + m) * 60 + s
				if sign == '-'
					let duration = -duration
				endif
			endif
		endif
		let total += duration
	endfor

	return s:secs_to_dur(total)
endfunc

func SumDurationRange(...) abort range
	if a:0 > 2
		throw 'Expected at most 2 arguments for'
		\   . 'SumDurationRange, got ' . a:0 . '.'
	endif

	let first = a:000->get(0, a:firstline)
	let last = a:000->get(1, a:000->get(0, a:lastline))

	let lines = getline(first, last)
	if len(lines) == 1
		let durations = []
		" With help from https://stackoverflow.com/a/34069943
		call substitute(
		\	lines[0],
		\	s:pat,
		\	'\=add(durations, submatch(0))',
		\	'g')
	else
		let durations = lines->map('v:val->matchstr(s:pat)')
	endif

	if empty(durations)
		throw 'No valid durations in given range.'
	endif

	return SumDurations(durations)
endfunc

command -bang -range
\	SumDurations
\		echo SumDurationRange(<line1>, <line2>)

let &cpo = s:cpo_save
unlet s:cpo_save
