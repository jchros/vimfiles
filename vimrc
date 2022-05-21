" 1,000 thanks to romainl for his "idiomatic vimrc" project.
" Give it a read: https://github.com/romainl/idiomatic-vimrc#readme

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
if has('unix') && !exists('g:NO_INSTALL_PLUG')
    call kkp#try_to_get_vim_plug()
endif

let s:vim_plug_folder = expand('<sfile>:p:h') . '/plugged'
call plug#begin(s:vim_plug_folder)

" Get and update vim-plug's documentation
Plug 'junegunn/vim-plug'

" Plugins for working with Git {{{2
Plug 'tpope/vim-fugitive'
" Git ↑
" Hub ↓
Plug 'tpope/vim-rhubarb'
" Show changes/additions/deletions on the sign column (for git, etc.)
Plug 'mhinz/vim-signify'
" Custom text objects {{{2

" Indent objects; useful for Python
Plug 'michaeljsmith/vim-indent-object'

" THE FOLLOWING PLUGINS RELY ON THIS ONE
Plug 'kana/vim-textobj-user'
" Function and class text objects for Python
Plug 'bps/vim-textobj-python'
" List element (or function argument) text object; language agnostic
Plug 'sgur/vim-textobj-parameter'

if executable('nvim')  " {{{2
let Nvim = has('nvim') ? {} : #{on: []}
func Nvim(opts)
    return extend(a:opts, g:Nvim)
endfunc
" Auto-completion backend
Plug 'hrsh7th/nvim-cmp', Nvim
" TabNine completions
Plug 'tzachar/cmp-tabnine', Nvim(#{do: './install.sh'})
" Omnifunc completions
Plug 'hrsh7th/cmp-omni', Nvim
" Path completions
Plug 'hrsh7th/cmp-path', Nvim
" Buffer completions
Plug 'hrsh7th/cmp-buffer', Nvim
" LSP completions
Plug 'hrsh7th/cmp-nvim-lsp', Nvim
" Integration of vsnip into cmp
Plug 'hrsh7th/cmp-vsnip', Nvim
" Client for Eclipse JDT's LSP
Plug 'mfussenegger/nvim-jdtls', Nvim
" A nice colorscheme
Plug 'rebelot/kanagawa.nvim', Nvim
unlet Nvim | delfunc Nvim
endif " }}}2

let VimOnly = has('nvim') ? #{on: []} : {}
" Convenient Vim wrappers for Unix commands
Plug 'tpope/vim-eunuch'
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
Plug 'vim/killersheep', VimOnly
" Allows you to swap two text objects
Plug 'jchros/vim-exchange', #{branch: 'persist-hl-status-on-cs-change'}
" Allows for smooth scrolling
Plug 'psliwka/vim-smoothie'
" A plugin to ensure files are well-formatted
Plug 'editorconfig/editorconfig-vim'
" Emmet completion for HTML/CSS
Plug 'mattn/emmet-vim'
" Integration of linters in Vim
Plug 'drgarcia1986/python-compilers.vim'
" A REPL plugin for Common Lisp
Plug 'vlime/vlime', #{rtp: 'vim/'}
" Smarter substitutions and easySwitching between letter_casings
Plug 'tpope/vim-abolish'
" Automagically balances parentheses in Lisp files
if executable('cargo')
    Plug 'eraserhd/parinfer-rust', #{do: 'cargo build --release'}
else
    Plug 'bhurlow/vim-parinfer'
endif

if has('osxdarwin')
    Plug '~/.vim/plugged/iTunes-current-track'
endif

" Focus in one section of text by removing the rest
Plug 'chrisbra/NrrwRgn'
" Preview substitution patterns
Plug 'markonm/traces.vim', VimOnly
" Caps lock for Vim
Plug 'tpope/vim-capslock'
" I mostly use this plugin for brace expansion
Plug 'Olical/vim-expand'
" Automatically update HTML tags
Plug 'AndrewRadev/tagalong.vim'
" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" A color scheme
Plug 'srcery-colors/srcery-vim'
unlet VimOnly

call plug#end()

" OPTIONS {{{1

let mapleader      = ' '  " 1 space
let maplocalleader = "\t"

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
se number                 " the current line number and
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
se linebreak              " ... but when it's enabled, break
                          " lines on word boundaries

" MISCELLANEOUS {{{1

execute 'colorscheme' (has('nvim') ? 'kanagawa' : 'srcery')

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
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:traces_abolish_integration = 1

" The following command is taken from Vim's default vimrc (for files
" which have no VIMRC) and is thus licensed under Vim's license.
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

au BufNewFile,BufRead .clang-format set filetype=yaml

if has('viminfo')
    let &viminfofile = expand('sfile>:p:h') . '/viminfo'
endif

let g:vsnip_snippet_dir = expand('<sfile>:p:h') . '/snippets'

" Taken from here: https://www.reddit.com/r/vim/comments/usktg6/relative_numbers_to_absolute_when_entering/i95o1iq/
augroup numbertoggles
    au!
    nnoremap <expr> : '<cmd>set norelativenumber<cr>' . (v:count ? v:count : '') . ':'
    au OptionSet number execute(v:option_new ? 'nnoremap <expr> : "<cmd>set norelativenumber<cr>" . (v:count ? v:count : "") . ":"' : 'nunmap :')
    au CmdlineLeave : if &number | set relativenumber | endif
augroup END
