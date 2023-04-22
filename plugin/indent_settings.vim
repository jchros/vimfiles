function! GlobalIndentTabs(indent_width = v:null) abort
	if a:indent_width
		let &tabstop = a:indent_width
	endif

	set noexpandtab softtabstop=0 shiftwidth=0
endfunction

function! LocalIndentTabs(indent_width = v:null) abort
	if a:indent_width
		let &l:tabstop = a:indent_width
	endif

	setlocal noexpandtab softtabstop=0 shiftwidth=0
endfunction

function! IndentTabs(indent_width = v:null, global = v:false) abort
	if a:global
		call GlobalIndentTabs(a:indent_width)
	else
		call LocalIndentTabs(a:indent_width)
	endif
endfunction

function! GlobalIndentSpaces(indent_width = 0) abort
	let &shiftwidth = a:indent_width
	set expandtab softtabstop=0
endfunction

function! LocalIndentSpaces(indent_width = 0) abort
	let &shiftwidth = a:indent_width
	setlocal expandtab softtabstop=0
endfunction

function! IndentSpaces(indent_width = 0, global = v:false) abort
	if a:global
		call GlobalIndentSpaces(a:indent_width)
	else
		call LocalIndentSpaces(a:indent_width)
	endif
endfunction

command! -bang -bar -count IndentTabs
\	call IndentTabs(<count> ? <count> : v:null, <bang>0)
command! -bang -bar -count IndentSpaces
\	call IndentSpaces(<count> ? <count> : v:null, <bang>0)
command! -bang -bar -count TIndent <count>IndentTabs<bang>
command! -bang -bar -count SIndent <count>IndentSpaces<bang>

nnoremap <Plug>(indent-space)
\	<Cmd>call LocalIndentSpaces(v:count)<CR>
nnoremap <Plug>(indent-tab)
\	<Cmd>call LocalIndentTabs(v:count)<CR>

nmap ><Space> <Plug>(indent-space)
nmap ><Tab>   <Plug>(indent-tab)
