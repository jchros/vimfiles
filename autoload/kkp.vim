" Some useful functions


" Vim requires that autoloaded functions are named using the following
" pattern: filename#funcname()
" (see :h autoload)
" The {expand('<sfile>:t:r')} trick allows you to get the current file
" name and to remove its extension (see :h expand()), and to insert it
" to the function's name using curly-braces-names
" This allows us to rename the file without changing any of its contents

fun {expand('<sfile>:t:r')}#FileExists(file) abort
    return !empty(glob(a:file))
endfun

fun {expand('<sfile>:t:r')}#VimFolder() abort
    if has('unix')
        return '~/.vim/'
    elseif has('win32')
        return '$HOME\vimfiles\'
    endif
    throw 'Unknown operating system'
endfun

fun {expand('<sfile>:t:r')}#get_vim_plug() abort
    if !{expand('<sfile>:t:r')}#user_wants_to('Get vim-plug?')
        return v:false
    endif
    echomsg 'Downloading vim-plug'
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echomsg 'Installing vim-plug'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    return v:true
endfun

fun {expand('<sfile>:t:r')}#user_wants_to(prompt) abort
    let [l:yes, l:no] = [1, 2]
    let l:res = confirm(a:prompt, "&Yes\n&No")
    return l:res == l:yes
endfun

fun {expand('<sfile>:t:r')}#has_viminfo_bang() abort
    let viminfo = has('viminfo') ? &viminfo : (has('nvim') ? &shada : '')
    return index(split(viminfo, ','), '!') != -1
endfun

fun {expand('<sfile>:t:r')}#try_to_get_vim_plug() abort
    if !has('dialog_' . (has('gui_running') ? 'gui' : 'con'))
        " Can't ask if the user wants to get vim-plug; default to no
        return
    endif

    let vim_plug_path = '~/.vim/autoload/plug.vim'
    if kkp#FileExists(vim_plug_path)
        " No need to install
        return
    endif
    if !{expand('<sfile>:t:r')}#get_vim_plug()
        if {expand('<sfile>:t:r')}#has_viminfo_bang()
            let l:msg = 'Run the following command'
        else
            let l:msg = 'Add the following command to your vimrc'
        endif
        let l:msg.= 'to avoid being prompted in the future:'
        let l:msg.= "\n" . 'let g:NO_INSTALL_PLUG = v:true'
        echomsg l:msg
        return
    endif
endfun
