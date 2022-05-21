au BufNewFile,BufRead */doc/*.txt set filetype=help
au BufWritePost */doc/*.txt helptags <afile>:p:h
