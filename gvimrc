" NOTE: Many of these options only work on MacVim

se guioptions=c
se notitle

" When Vim shows a file browser, point it at the current directory
se browsedir=current

" Disable MacVim's default touch bar button
let g:macvim_default_touchbar_fullscreen=0

" SET FONTS {{{1
" Quickly see gVim's font size
nnoremap <leader>F :se gfn?<cr>
nnoremap <expr> <leader>f ':<c-u>set guifont=' . g:preferred_font . ':h' .
\(v:count ? v:count . '<cr>' : '')

let g:preferred_font="Rec\\ Mono\\ Linear"
let s:default_font_size=14
execute 'se gfn=' . g:preferred_font . ':h' . s:default_font_size

