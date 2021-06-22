if executable('cmus') && executable('cmus-remote')
	command -nargs=* -bar Cmus <mods> ter ++close <args> cmus
	nnoremap <silent> <leader>c :call system('cmus-remote -u')<cr>
	tnoremap <silent> <C-W><leader>c :call system('cmus-remote -u')<cr>
endif
