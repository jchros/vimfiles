if executable('cmus') && executable('cmus-remote')
	if has('nvim')
		command -bar Cmus <mods> new term://cmus
	else
		command -nargs=* -bar Cmus <mods> ter ++close <args> cmus
	endif
	nnoremap <silent> <leader>c <Cmd>call system('cmus-remote -u')<cr>
	nnoremap <silent> <leader>C <Cmd>call system('cmus-remote', 'toggle continue')<cr>
	tnoremap <silent> <C-W><leader>c <Cmd>call system('cmus-remote -u')<cr>
	tnoremap <silent> <C-W><leader>C <Cmd>call system('cmus-remote', 'toggle continue')<cr>
endif
