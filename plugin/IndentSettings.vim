function! GlobalIndentTabs(indent_width = v:none) abort
  if a:indent_width isnot v:none
    let &tabstop = a:indent_width
  endif

  let &shiftwidth = a:indent_width
  set noexpandtab
endfunction

function! LocalIndentTabs(indent_width = v:none) abort
  if a:indent_width isnot v:none
    let &l:tabstop = a:indent_width
  endif

  let &l:shiftwidth = a:indent_width
  setlocal noexpandtab
endfunction

function! IndentTabs(indent_width = v:none, global = v:false) abort
  if a:global
    call GlobalIndentTabs(a:indent_width)
  else
    call LocalIndentTabs(a:indent_width)
  endif
endfunction

function! GlobalIndentSpaces(indent_width = 0) abort
  let &shiftwidth = a:indent_width
  set expandtab
endfunction

function! LocalIndentSpaces(indent_width = 0) abort
  let &shiftwidth = a:indent_width
  setlocal expandtab
endfunction

function! IndentSpaces(indent_width = 0, global = v:false) abort
  if a:global
    call GlobalIndentSpaces(a:indent_width)
  else
    call LocalIndentSpaces(a:indent_width)
  endif
endfunction

command! -bang -bar -nargs=? IndentTabs
\     call IndentTabs(<q-args> ? <q-args> : v:none, <bang>0)
command! -bang -bar -nargs=? IndentSpaces
\     call IndentSpaces(<q-args> ? <q-args> : v:none, <bang>0)
command! -bang -bar -nargs=? TIndent IndentTabs<bang>   <args>
command! -bang -bar -nargs=? SIndent IndentSpaces<bang> <args>
