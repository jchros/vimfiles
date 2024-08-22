" 1,000 thanks to romainl for his "idiomatic vimrc" project.
" Give it a read: https://github.com/romainl/idiomatic-vimrc#readme

let g:vimfiles_dir = expand('<sfile>:p:h')
call packages#()

let s:fzf_location = systemlist('brew --prefix fzf')[0]
if !empty(s:fzf_location)
    let &runtimepath .= ',' . s:fzf_location
else
    call minpac#add('junegunn/fzf', { -> fzf#install() })
endif

" OPTIONS {{{1

let mapleader      = ' '  " 1 space
let maplocalleader = '  ' " 2 spaces

se autoindent

se autoread               " Update the file automatically when changed
                          " outside of Vim

                          " Make it so that backspace can:
se backspace=indent       " - remove a level of indentation
se backspace+=eol         " - remove new lines characters
if !has('patch-8.2.0590') && !has('nvim-0.5.0')
    se backspace+=start   " - backspace before the insertion point
else                      "   but if your Vim is recent enough...
    se backspace+=nostop  "   ... then <C-W> and <C-U> can remove
endif                     "   characters before the insertion point too.

se belloff=all            " Remove Vim's annoying sounds

se clipboard=             " Don't use the system clipboard as the
                          " default register

se completeopt=           " Completion options
se completeopt+=menuone   " Show the popup menu even
                          " if there's only 1 match
se completeopt+=preview   " Show extra information in an other window
se completeopt+=noinsert  " Don't insert anything unless I ask to
se completeopt+=noselect  " Don't automatically select the first match

se confirm                " Ask for confirmation when deleting an
                          " unsaved buffer

se cursorline             " Highlight the cursor's line

se encoding=utf8

se fillchars=             " Option used to customise separators
se fillchars+=vert:│      " Change vertical split separator;
                          " use box-drawing characters instead of │ vs |
                          " a vertical bar, see the lines here →  │ vs |

if has('folding')         " Creates folds using markers
    se foldmethod=marker  " (i.e: those triple braces sprinkled all over
endif                     " this file)

se formatoptions=
se formatoptions+=c       " Use 'textwidth' to wrap comments
se formatoptions+=q       " and allow comment formatting with gq and gw
se formatoptions+=2       " Use the indent of the second line in
                          " subsequent lines of a paragraph if it
                          " differs from that of the first line
se formatoptions+=j       " Remove comment leaders when joining lines
se formatoptions+=o       " Add comment leaders when using o

se hidden                 " Switch between buffers without having to
                          " save first

se ignorecase             " Ignore casing by default in patterns
se smartcase              " unless there are any uppercased characters
                          " in them

se nojoinspaces           " always add a single space when using J

if has('nvim')
    se laststatus=3       " Show only one status line, at the bottom
else
    se laststatus=1       " Show status line when there are 2+ windows
endif

se list listchars=        " Render visible:
se listchars+=tab:│\      " - tabs
se listchars+=trail:·     " - trailing spaces
se listchars+=nbsp:¬      " - non-breaking spaces

se mouse=                 " Disable the mouse

se nomodeline             " Modelines are unsafe; disable them

                          " Enable <C-A> and <C-X> for:
se nrformats=bin          " - binary literals
se nrformats+=hex         " - hexadecimal literals
se nrformats+=octal       " - octal literals

se numberwidth=3          " Use 3 columns to display
se number                 " the current line number and
se relativenumber         " the line number relative to the cursor line
                          " See `:h number_relativenumber`

se noruler                " Don't show additonal info in the echo area

se scrolloff=3            " There should always be at least 3 lines
                          " above and below the cursor, otherwise scroll
                          " the text if possible
                          " (the choice of the number 3 was inspired by
                          " git, which shows 3 lines of context around
                          " hunks by default)

if has('extra_search')
    set incsearch         " Update search results as you type

    if !&hlsearch         " Don't highlight results when resourcing this
                          " file
        set hlsearch      " Enable result highlighting
    endif
endif

if has('cmdline_info')
    se showcmd
endif

se noswapfile             " Disable swap files, use a VCS instead

if has('termguicolors')   " Use the same colors in the terminal as the
    se termguicolors      " colors that would be used in GVim
endif

se ttimeout               " time out for key codes
se ttimeoutlen=50         " wait up to 50ms after Esc for special key

if has('wildmenu')        " Display completion matches in a status line
    se wildmenu
endif

let s:wildignore =<< trim END
    */node_modules/*
    */.git/*
    */__pycache__/*
END
let &wildignore .= join(s:wildignore, ',')

se wildmode=longest       " Complete longest common string,
se wildmode+=full         " then each full match

se nowrap                 " Disable line wrapping
se linebreak              " ... but when it's enabled, break
                          " lines on word boundaries

" MISCELLANEOUS {{{1

if !has('nvim')
    colorscheme srcery
endif

" Options for emmet-vim {{{2
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,javascript EmmetInstall

" augroups {{{2
augroup DisableList  " {{{3
    au!
    au FileType man setlocal nolist
augroup END
augroup disableNETRWFoldColumn  " {{{3
    au!
    au BufEnter,WinEnter * if &filetype ==? 'netrw' | se foldcolumn=0
augroup END
" }}}2

packadd! matchit  " Improved % matching

" Disable EditorConfig in remote files and fugitive,
" as suggested in the repo's README on GitHub
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:lisp_rainbow = v:true

" Browse man pages without exiting Vim (see :help :Man)
runtime ftplugin/man.vim

" Allow modifying and writing to a protected file
command -bar -bang Writeable set modifiable noreadonly

command -bar -nargs=? -complete=dir Tex Texplore <args>
command -bar -nargs=? -complete=dir Ex Explore <args>

" Digraph for inserting narrow non-breaking spaces
digraph NN 8239

" Enable folding of manpage sections
let g:ft_man_folding_enable = 1

" The following function is taken from this Stack Overflow answer by
" romainl: https://stackoverflow.com/a/9464929/13193502
" It tells you what syntax groups apply to the text under the cursor.
function! SynStack()
  if !exists("*synstack")
    return []
  endif
  return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

func s:ynstack() abort
    if exists(':TSHighlightCapturesUnderCursor')
        TSHighlightCapturesUnderCursor
    else
        echo SynStack()
    endif
endfunc

command -bar SynStack call <SID>ynstack()

let g:traces_abolish_integration = 1

" The following command is taken from Vim's default vimrc (for files
" which have no VIMRC) and is thus licensed under Vim's license.
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig
  \  vert new
  \| set bt=nofile
  \| let &syntax = getbufvar('#', '&filetype')
  \| r ++edit #
  \| 0d_
  \| diffthis
  \| execute 'autocmd BufWritePost <buffer=' . bufnr('#') . '> ++once'
  \     'try | bd' bufnr() '| endtry'
  \| wincmd p
  \| diffthis
endif

au BufNewFile,BufRead .clang-format set filetype=yaml

if has('viminfo')
    let &viminfofile = g:vimfiles_dir . '/viminfo'
endif

let g:vsnip_snippet_dir = g:vimfiles_dir . '/snippets'

" Remove Vim's weird "double-indent in parens" on Python files
let g:pyindent_disable_parentheses_indenting = 1

command -nargs=+ -bar -bang -complete=custom,open_note#complete
\   OpenNote call open_note#cmd_interface(#{
\       bang: <bang>0,
\       mods: '<mods>',
\       name: [<f-args>][0],
\       desc: join([<f-args>][1:]),
\   })

" Turn off parinfer by default in tree-sitter query files
" works only with parinfer-rust
augroup disable_parinfer_on_tree_sitter_queries
    au!
    au BufNewFile,BufRead {locals,highlights,textobjects}.scm
    \   silent! ParinferOff
augroup END
