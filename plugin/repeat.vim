" Character Repeat
nnoremap cr a<c-r>=getline('.')[getpos('.')[2]-2]<cr><esc><cmd>call repeat#set('cr')<cr>

" Delete Repeat (a.k.a swap)
func! DRepeat() abort
	let [i, j] = [line('.'), line('.') + v:count1 - 1]
	let lines = getline(i, j)
	call assert_equal(0, deletebufline('', i, j), 'failed to delete lines')
	call assert_equal(0, append('.', lines), 'failed to add lines')
	execute '+' .. v:count1
	silent! call repeat#set('dr')
endfunc

nnoremap dr <cmd>call DRepeat()<cr>

" Yank Repeat (a.k.a duplicate)
nnoremap yr <cmd>eval append(line('.') - 1, getline('.', line('.') + v:count1 - 1)) <bar><bar> repeat#set('yr')<cr>
