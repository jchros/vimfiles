if executable('cmus') && executable('cmus-remote')
	nnoremap <silent> <leader>c :call system('cmus-remote -u')<cr>
endif
