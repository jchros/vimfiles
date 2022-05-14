" Some useful functions

" Vim requires that autoloaded functions are named using the following
" pattern: filename#funcname()
" (see :h autoload)
" The {expand('<sfile>:t:r')} trick allows you to get the current file
" name and to remove its extension (see :h expand()), and to insert it
" to the function's name using curly-braces-names
" This allows us to rename the file without changing any of its contents
let s:f = expand('<sfile>:t:r')

fun {s:f}#file_exists(file) abort
    return !empty(glob(a:file))
endfun

fun {s:f}#get_vim_plug() abort
    if !{s:f}#user_wants_to('Get vim-plug?')
        return v:false
    endif
    echomsg 'Downloading vim-plug'
    !curl -fLo <sfile>:p:h/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echomsg 'Installing vim-plug'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    return v:true
endfun

fun {s:f}#user_wants_to(prompt) abort
    if !has('dialog_gui') && !has('dialog_con')
        throw "Can't use confirm() without the +dialog_con feature."
    endif
    let [yes, no] = [1, 2]
    let res = confirm(a:prompt, "&Yes\n&No")
    return res == yes
endfun

fun {s:f}#has_viminfo_bang() abort
    let viminfo = has('viminfo') ? &viminfo : (has('nvim') ? &shada : '')
    return index(split(viminfo, ','), '!') != -1
endfun

fun {s:f}#try_to_get_vim_plug() abort
    let vim_plug_path = expand('<sfile>:p:h') . '/autoload/plug.vim'
    if {s:f}#file_exists(vim_plug_path)
        " No need to install
        return
    elseif {s:f}#get_vim_plug()
        " vim-plug has been installed; exit
        return
    endif
    if {s:f}#has_viminfo_bang()
        let do_this = 'Run the following command'
    else
        let do_this = 'Add the following command atop the vimrc'
    endif
    echomsg do_this 'to avoid being prompted in the future:'
    echomsg 'let g:NO_INSTALL_PLUG = v:true'
endfun
