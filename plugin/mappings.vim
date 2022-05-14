" Define a mapping that will be available from normal mode
" as well as from Vim's terminal mode — but not from NeoVim's
function s:Map(lhs, rhs, ...) abort
	" Parse options
        let opts = a:000
	let silent = index(opts, "silent") > 0

	" Form command
	let cmd = 'map'
	if silent
		let cmd .= ' <silent>'
	endif

	" Define mapping for normal mode
	execute 'n'.cmd a:lhs a:rhs

	" Define mapping for Vim's terminal mode
	if exists('termwinkey')
		let twk = len(&termwinkey) ? &termwinkey : '<C-W>'
		execute 't'.cmd twk.a:lhs twk.a:rhs
	endif
endfunction

" A Magit-inspired mapping; useful for making commits
nnoremap <C-C><C-C> <Cmd>xit<cr>

" Clear search highlighting
nnoremap <leader>l <Cmd>nohlsearch<cr>

" Quickly edit your .vimrc
nnoremap <leader>v <Cmd>tabedit $MYVIMRC<cr>

" Save without staging changes
nnoremap <leader>w <Cmd>w<cr>
" Save and stage changes
nnoremap <leader>W <Cmd>Gw<cr>

" Open Fugitive's summary window
nnoremap <leader>g <Cmd>G<cr>
" Same, but vertically
nnoremap <leader>G <Cmd>vert G<cr>

" Remove other windows of current tab
nnoremap <leader>o <C-W>o

" Quick buffer navigation {{{1
" Read https://stackoverflow.com/a/24903110
call s:Map('gb', ':ls<cr>:b')

" Open existing buffer in new tab
call s:Map('gB', ':ls<cr>:tab sbuffer<Space>')
" in a vertical split
call s:Map('<leader>b', ':ls<cr>:vert sbuffer<Space>')
"in a horizontal split
call s:Map('<leader>B', ':ls<cr>:sbuffer<Space>')

" Quick tab navigation {{{1
" Make it easier to switch tabs
call s:Map('gr', 'gT')

" Quickly close tabs
call s:Map('<leader>x', '<Cmd>tabclose<cr>')
" }}}1

" Remap ZQ to quit all
call s:Map('ZQ', '<Cmd>qall<cr>')
" (since we'll set the conf option,
" a confirmation prompt will be displayed)

" Close all other tabs
call s:Map('zq', '<Cmd>tabonly<cr>')

" Don't insert non-breaking spaces in text
noremap!        <Space>

nnoremap ² <C-]>

" <C-A> and <C-X> for alphabetical characters
" without changing the value of 'nrformats'
function s:CtrlAVariable(...)
	let [oldnf, &l:nrformats] = [&nrformats, 'alpha']
	execute 'normal ' . (a:0 ? 'g' : '') . "\<c-a>"
	let &l:nrformats = oldnf
endfunction

function s:CtrlXVariable(...)
	let [oldnf, &l:nrformats] = [&nrformats, 'alpha']
	execute 'normal ' . (a:0 ? 'g' : '') . "\<c-x>"
	let &l:nrformats = oldnf
endfunction

map <leader>A <Cmd>call <sid>CtrlAVariable()<CR>
map <leader>X <Cmd>call <sid>CtrlXVariable()<CR>
vmap <leader>a <Cmd>call <sid>CtrlAVariable(0)<CR>
vmap <leader>x <Cmd>call <sid>CtrlXVariable(0)<CR>

nnoremap vx :Expand<CR>
xnoremap vx :Expand<CR>

" Quickly insert a blank line {{{1
"
" Add line(s) below the cursor
" Why not simply do "nnoremap § o<Esc>kgM" ?
" When given a count, this mapping translates to "<count>o<Esc>kgM".
" This adds <count> blank lines below the cursor with the "o" command
" (which also moves the cursor to the last line added), then moves the
" cursor up 1 line. Thus, the cursor will always be moved
" count - 1 lines below the line from which the mapping is called.
" This version of the mapping adds a count to the "k" in order to move
" the cursor up by just as many lines as were added by "o".
nnoremap <expr> § 'o<Esc>' . v:count1 . 'kgM'

" Add line(s) above the cursor
" We don't need to do the same thing as above for these mappings;
" since the last line added by "O" always ends up above the
" current line, we only need to move the cursor down once.
if !empty($AZERTY)
    nnoremap ¶ O<Esc>jgM
else
    nnoremap ± O<Esc>jgM
endif

if !empty($AZERTY) " {{{1
    " Toggle casing of a single character
    noremap ç ~
    " Toggle casing of a word
    vnoremap Ç viwç

    " Typing the pipe character is inconvenient in AZERTY keyboards
     noremap! § \|
    tnoremap  § \|
else
    " § is closer to the home row than <Esc>
    onoremap  § <Esc>
    vnoremap  § <Esc>
     noremap! § <Esc>
    tnoremap  § <Esc>
endif

" Use evil-exchange's mappings {{{1
let g:exchange_no_mappings = v:true
nmap gx  <Plug>(Exchange)
xmap  X  <Plug>(Exchange)
nmap gxc <Plug>(ExchangeClear)
nmap gxx <Plug>(ExchangeLine)

" For vim-vsnip {{{1
imap <expr> <c-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ''
smap <expr> <c-b> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : ''
