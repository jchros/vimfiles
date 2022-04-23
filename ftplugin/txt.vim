autocmd BufNewFile ~/.vim/doc/*.txt call append(0, '*;' . expand('%:t:r') . '*')
