let mapleader      = ' '   " 1 space
let maplocalleader = "\t"

" cmus {{{1
" Playpause
nnoremap <silent> <leader>c :call system("cmus-remote -u")<cr>
" }}}1

" A Magit-inspired mapping; useful for making commits
nnoremap <C-C><C-C> :xit<cr>

" Clear search highlighting
nnoremap <silent> <leader>l :<C-U>nohlsearch<cr>

nnoremap <silent> <leader>L :<C-U>AirlineRefresh<cr>

" Quickly edit your .vimrc
nnoremap <silent> <leader>v :<C-U>tabedit $MYVIMRC<cr>
" Quickly edit your gvimrc
nnoremap <silent> <leader>V :<C-U>tabedit $MYGVIMRC<cr>

" Save without staging changes
nnoremap <silent> <leader>w :<C-U>w<cr>
" Save and stage changes
nnoremap <silent> <leader>W :<C-U>Gw<cr>

" Open Fugitive's summary window
nnoremap <leader>g :<C-U>G<cr>

" Navigate through windows {{{1
nnoremap <leader>o <C-W>o
nnoremap <leader>O <C-W>c

" Quick buffer navigation {{{1
" Read https://stackoverflow.com/a/24903110
nnoremap      gb      :ls<cr>:b
tnoremap <C-W>gb <C-W>:ls<cr>:b

" Open existing buffer in new tab
nnoremap      gB      :ls<cr>:tab sbuffer<Space>
tnoremap <C-W>gB <C-W>:ls<cr>:tab sbuffer<Space>

" Quick tab navigation {{{1
" Make it easier to switch tabs
noremap       gr      gT
tnoremap <C-W>gr <C-W>gT

" Quickly close tabs
noremap  <silent> <leader>x      :tabclose<cr>
tnoremap <silent> <C-W>x    <C-W>:tabclose<cr>
" }}}1

" Remap ZQ to quit all
noremap  <silent>      ZQ      :qall<cr>
tnoremap <silent> <C-W>ZQ <C-W>:qall<cr>
" (since we'll set the conf option,
" a confirmation prompt will be displayed)

" Don't insert non-breaking spaces in text
noremap!        <Space>

" Automatically close braces, brackets, parentheses
inoremap {<CR> {<CR>}<C-O>O
inoremap [<CR> [<CR>]<C-O>O
inoremap (<CR> (<CR>)<C-O>O

nnoremap ² <C-]>

" Quickly insert a blank line {{{1
"
" Add line(s) below the cursor
" Why not simply do "nnoremap § o<Esc>kgM" ?
" When given a count, this mapping translates to "<count>o<Esc>kgM".
" This adds <count> blank lines below the cursor with the "o" command
" (which also moves the cursor to the last line added), then moves the
" cursor up 1 line. Thus, the cursor will always be moved
" count - 1 lines below the line from which the mapping is called.
" This version of the mapping adds a count to the "k" in order to move
" the cursor up by just as many lines as were added by "o".
nnoremap <expr> § 'o<Esc>' . v:count1 . 'kgM'

" Add line(s) above the cursor
" We don't need to do the same thing as above for these mappings;
" since the last line added by "O" always ends up above the
" current line, we only need to move the cursor down once.
if !empty($AZERTY)
    nnoremap ¶ O<Esc>jgM
else
    nnoremap ± O<Esc>jgM
endif

if !empty($AZERTY) " {{{1
    " Toggle casing of a single character
    noremap ç ~
    " Toggle casing of a word
    vnoremap Ç viwç

    " Typing the pipe character is inconvenient in AZERTY keyboards
     noremap! § \|
    tnoremap  § \|
else
    " § is closer to the home row than <Esc>
    onoremap  § <Esc>
    vnoremap  § <Esc>
     noremap! § <Esc>
    tnoremap  § <Esc>
endif

" Use evil-exchange's mappings {{{1
let g:exchange_no_mappings = v:true
nmap gx  <Plug>(Exchange)
xmap  X  <Plug>(Exchange)
nmap gxc <Plug>(ExchangeClear)
nmap gxx <Plug>(ExchangeLine)
