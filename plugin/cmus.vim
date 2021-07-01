if executable('cmus') && executable('cmus-remote')
	command -nargs=* -bar Cmus <mods> ter ++close <args> cmus
	nnoremap <silent> <leader>c :call system('cmus-remote -u')<cr>
	nnoremap <silent> <leader>C :call system('cmus-remote', 'toggle continue')<cr>
	tnoremap <silent> <C-W><leader>c :call system('cmus-remote -u')<cr>
	tnoremap <silent> <leader>C :call system('cmus-remote', 'toggle continue')<cr>
endif
