if executable('cmus') && executable('cmus-remote')
	if has('nvim')
		command -bar Cmus <mods> new term://cmus
	else
		command -nargs=* -bar Cmus <mods> ter ++close <args> cmus
	endif
	nnoremap <leader>c <Cmd>call system('cmus-remote -u')<cr>
	nnoremap <leader>C <Cmd>call system('cmus-remote -C toggle\ continue')<cr>
	if !has('nvim')
		tnoremap <C-W><leader>c <Cmd>call system('cmus-remote -u')<cr>
		tnoremap <C-W><leader>C <Cmd>call system('cmus-remote -C toggle\ continue')<cr>
	endif
endif
