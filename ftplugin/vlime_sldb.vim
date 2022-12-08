nnoremap <silent> <buffer> <expr> <leader>f ':<c-u>keeppatterns /^Frames:$/+' . (v:count + 1) . '<cr>'
nnoremap <silent> <buffer> <expr> <leader>r ':<c-u>keeppatterns /^Restarts:$/+' . (v:count + 1) . '<cr>'
