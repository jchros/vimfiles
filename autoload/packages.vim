func packages#()
	let opt = #{type: 'opt'}
	let s:opt = { config -> extend(config, opt)}
	silent! packadd minpac
	if !exists('g:loaded_minpac')
		return packages#try_to_get_minpac()
	endif
	call minpac#init()
	call minpac#add('k-takata/minpac', opt)

	if executable('nvim') " {{{1
		call minpac#add('rebelot/kanagawa.nvim', opt)
		" Language servers {{{2
		call minpac#add('mfussenegger/nvim-jdtls', opt)
		" tree-sitter {{{2
		call minpac#add('nvim-treesitter/nvim-treesitter', s:opt(#{do: {->has('nvim') && execute('TSUpdate')}}))
		call minpac#add('nvim-treesitter/playground', opt)
		call minpac#add('p00f/nvim-ts-rainbow', opt)
	endif " }}}1

	" Text object plugins {{{1
	call minpac#add('michaeljsmith/vim-indent-object')
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('sgur/vim-textobj-parameter')

	call minpac#add('bps/vim-textobj-python')

	" Tim Pope plugins {{{1
	call minpac#add('tpope/vim-abolish')
	call minpac#add('tpope/vim-capslock')
	call minpac#add('tpope/vim-eunuch')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-rhubarb')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-vinegar')
	autocmd VimEnter * ++once nunmap -
	call minpac#add('tpope/vim-dadbod')

	" Plugins related to file types {{{1

	" A Vim equivalent to SLIME (for Common Lisp)
	call minpac#add('vlime/vlime', #{rtp: 'vim'})

	" Automagically balance parentheses in Lisp
	eval function('minpac#add', executable('cargo')
		\ ? [ 'eraserhd/parinfer-rust', #{do: {-> system('cargo build --release')}} ]
		\ : [ 'bhurlow/vim-parinfer' ])()

	" Adds ":compiler"s for Python
	call minpac#add('drgarcia1986/python-compilers.vim')

	" Emmet completion (most useful for HTML, XML, CSS…)
	call minpac#add('mattn/emmet-vim')

	" Automatically update HTML/XML tags
	call minpac#add('AndrewRadev/tagalong.vim')

	" Plugins that don't fit into the above categories {{{1

	" Color scheme editor
	call minpac#add('lifepillar/vim-colortemplate', opt)
	if has('patch-8.0.0')
		packadd vim-colortemplate
	endif

	" Integration with EditorConfig
	call minpac#add('editorconfig/editorconfig-vim')

	" A little game showing off some of Vim 8's features (Vim 8.2+ only)
	call minpac#add('vim/killersheep', opt)
	if has('patch-8.1.1705') && has('textprop')
		packadd killersheep
	endif
	
	" A completion engine for Vim
	call minpac#add('lifepillar/vim-mucomplete', opt)

	" "Narrow" a region of a file into its own buffer
	call minpac#add('chrisbra/NrrwRgn')

	" Automatically add closing braces, quotation marks, etc.
	call minpac#add('tmsvg/pear-tree')

	" Highlights characters for efficient use of f, F, t and T
	call minpac#add('unblevable/quick-scope')

	" Show changes/additions/deletions on the sign column (for git, etc.)
	call minpac#add('mhinz/vim-signify')

	" Smooth scrolling, to keep track of the cursor after a CTRL-D, CTRL-U, etc.
	call minpac#add('psliwka/vim-smoothie')

	" Color scheme
	call minpac#add('srcery-colors/srcery-vim')

	" Align text with user-defined patterns
	call minpac#add('godlygeek/tabular')

	" Preview substitution patterns (this is only useful in Vim)
	call minpac#add('markonm/traces.vim', opt)
	if !has('nvim')
		packadd traces.vim
	endif

	filetype plugin indent on
	if has('vim_starting') && !exists('g:syntax_on')
		syn on
	endif

	" }}}1
endfunc

func s:user_wants_to(prompt, ...) abort
	if !has('dialog_gui') && !has('dialog_con')
		throw "Can't use confirm() without the +dialog_con feature."
	endif
	let [yes, no] = [1, 2]
	let res = confirm(a:prompt, "&Yes\n&No", get(a:, 1) ? yes : no)
	return res == yes
endfunc

func s:has_viminfo_bang() abort
	let viminfo = has('viminfo') ? &viminfo : (has('nvim') ? &shada : '')
	return index(split(viminfo, ','), '!') != -1
endfun

func packages#try_to_get_minpac() abort
	if !executable('git')
		echoerr "You need git in order to install and use minpac"
		return
	endif
	if !s:user_wants_to('Install minpac?')
		if s:has_viminfo_bang()
			let do_this = 'Run the following command'
		else
			let do_this = 'Add the following command atop the vimrc'
		endif
		echomsg do_this 'to avoid being automatically prompted to install minpac:'
		echomsg 'let g:NO_INSTALL_MINPAC = v:true'
		return
	endif
	let packdir = split(&packpath, ',')[0] . '/pack/minpac/opt/minpac'
	execute '!git clone https://github.com/k-takata/minpac.git ' . shellescape(packdir)
	call packages#()
	if s:user_wants_to('Install plugins?')
		call minpac#update()
	endif
endfunc
