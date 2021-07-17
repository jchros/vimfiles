" 1,000 thanks to romainl for his "idiomatic vimrc" project.
" Give it a read: https://github.com/romainl/idiomatic-vimrc#readme

" SCRIPTVERSION {{{1
if has('scriptversion-3')
    " Enforce prefixing of Vim variables with 'v:'
    scriptversion 3
endif

" GUARDS {{{1
" This vimrc isn't very useful without the +eval and +syntax features

" See `:h no-eval-feature`
silent! while 0
    echoerr "Your Vim doesn't have the +eval feature."
    finish
silent! endwhile

if !has('syntax')
    echoerr "Your Vim doesn't have the +syntax feature."
    finish
endif

" VIM-PLUG {{{1

" Install vim-plug if you don't have it yet
" This will only work on Unix machines (BSD, Linux, etc.)
if has('unix')
    source ~/.vim/scripts/install-vim-plug.vim
endif

let s:vim_plug_folder = kkp#VimFolder() . 'plugged'
call plug#begin(s:vim_plug_folder)

" Get and update vim-plug's documentation
Plug 'junegunn/vim-plug'

" Plugins for working with Git {{{2
Plug 'tpope/vim-fugitive'
" Git ↑
" Hub ↓
Plug 'tpope/vim-rhubarb'
" Color schemes {{{2
Plug 'w0ng/vim-hybrid'
Plug 'srcery-colors/srcery-vim'
Plug 'habamax/vim-freyeday'
Plug 'beikome/cosme.vim'
Plug 'axvr/photon.vim'
Plug 'Softmotions/vim-dark-frost-theme'

" Custom text objects {{{2

" Indent objects; useful for Python
Plug 'michaeljsmith/vim-indent-object'

" THE FOLLOWING PLUGINS RELY ON THIS ONE
Plug 'kana/vim-textobj-user'

" Function and class text objects for Python
Plug 'bps/vim-textobj-python'

" List element (or function argument) text object; language agnostic
Plug 'sgur/vim-textobj-parameter'

" For NeoVim {{{2

" Auto-completion backend
Plug 'hrsh7th/nvim-compe'

" TabNine completions
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }

" }}}2


" Displays the relevant color for an RGB hex code or CSS color name
Plug 'ap/vim-css-color'

" Keybindings for manipulating parentheses, braces, HTML/XML tags, etc.
Plug 'tpope/vim-surround'

" Aligns text using user defined patterns
Plug 'godlygeek/tabular'

" Helps you naviagate to any word in the line using 'f' and 't'
Plug 'unblevable/quick-scope'

" Allows to use the dot command for plugins' custom mappings
Plug 'tpope/vim-repeat'

" A little video game showing off some of Vim's latest features
Plug 'vim/killersheep'

" Allows you to swap two text objects
Plug 'jchros/vim-exchange', {
\   'branch' : 'persist-hl-status-on-cs-change'
\}

" Allows for smooth scrolling
Plug 'psliwka/vim-smoothie'

" A plugin to ensure files are well-formatted
Plug 'editorconfig/editorconfig-vim'

" Emmet completion for HTML/CSS
Plug 'mattn/emmet-vim'

" Integration of linters in Vim
Plug 'drgarcia1986/python-compilers.vim'

" A REPL plugin for Common Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}

" Smarter substitutions and easySwitching between letter_casings
Plug 'tpope/vim-abolish'

" Automagically balances parentheses in Lisp files
Plug 'bhurlow/vim-parinfer'

" Templating plugin for the creation of Vim color schemes
Plug 'lifepillar/vim-colortemplate'

if has('osxdarwin')
    Plug '~/.vim/plugged/iTunes-current-track'
endif

" Focus in one section of text by removing the rest
Plug 'chrisbra/NrrwRgn'

" Automatically close brackets on newlines
Plug 'rstacruz/vim-closer'

" Preview substitution patterns
Plug 'markonm/traces.vim'

" Caps lock for Vim
Plug 'tpope/vim-capslock'

call plug#end()

" THEMING {{{1
let g:hybrid_reduced_contrast = 1

colorscheme darkfrost

" STORE VIMINFO INTO VIMFILES DIRECTORY {{{1
let s:viminfo_folder  = kkp#VimFolder() . 'viminfo'
if has('viminfo')
    silent call execute('se viminfofile=' . s:viminfo_folder)
endif

" OPTIONS {{{1
" Controversial indentation settings {{{2
se expandtab              " Prefer spaces over tabs
se tabstop=8              " Tabs are 8 columns wide
se shiftwidth=4           " Indent using 4 spaces
se softtabstop=-1         " <Tab> should insert 'sw' spaces
" }}}2

let mapleader      = ' '  " 1 space
let maplocalleader = "\t"

se autoindent

se autoread               " Update the file automatically when changed
                          " outside of Vim

                          " Make it so that backspace can:
se backspace=indent       " - remove a level of indentation
se backspace+=eol         " - remove new lines characters
if !has('patch-8.2.0590')
    se backspace+=start   " - backspace before the insertion point
else                      "   but if your Vim is recent enough...
    se backspace+=nostop  "   ... then <C-W> and <C-U> can remove
endif                     "   characters before the insertion point too.

se belloff=all            " Remove Vim's annoying sounds

se clipboard=             " Don't use the system clipboard as the
                          " default register

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

se hidden                 " Switch between buffers without having to
                          " save first

se ignorecase             " Ignore casing by default in patterns
se smartcase              " unless there are any uppercased characters
                          " in them

se nojoinspaces           " always add a single space when using J

se list listchars=        " Render visible:
se listchars+=tab:┃\      " - tabs
se listchars+=trail:·     " - trailing spaces
se listchars+=nbsp:¬      " - non-breaking spaces

se nomodeline             " Modelines are unsafe; disable them

                          " Enable <C-A> and <C-X> for:
se nrformats=bin          " - binary literals
se nrformats+=hex         " - hexadecimal literals
se nrformats+=octal       " - octal literals

se numberwidth=3          " Use 3 columns to display
se relativenumber         " the line number relative to the cursor line
                          " See `:h number_relativenumber`

se mouse=                 " Disable the mouse

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

se wildmode=longest       " Complete longest common string,
se wildmode+=full         " then each full match

se nowrap                 " Disable line wrapping

" MISCELLANEOUS {{{1

packadd! matchit      " Improved % matching

" Disable EditorConfig in remote files and fugitive,
" as suggested in the repo's README on GitHub
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Options for emmet-vim {{{2
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,javascript EmmetInstall

augroup disableNETRWFoldColumn  " {{{2
    au!
    au BufEnter,WinEnter * if &filetype ==? 'netrw' | se foldcolumn=0
augroup END  " }}}2

let g:lisp_rainbow = v:true

autocmd VimEnter * call insert(g:vim_parinfer_globs, '.*cl')

" Browse man pages without exiting Vim (see :help :Man)
runtime ftplugin/man.vim

" Allow modifying and writing to a protected file
command -bar -bang Writeable set modifiable noreadonly

command -bar -nargs=? Tex Texplore <arg>

" Digraph for inserting narrow non-breaking spaces
digraph NN 8239

" Enable folding of manpage sections
let g:ft_man_folding_enable = 1

augroup DisableList
    au!
    au FileType man setlocal nolist
augroup END
