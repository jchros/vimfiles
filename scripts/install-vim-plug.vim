" Automatically install vim-plug.
" You can turn this off by setting s:skip_vim_plug_install to v:true


" Helper functions {{{1
fun s:get_vim_plug() abort
    if !s:user_wants_to('Get vim-plug?')
        return v:false
    endif
    echomsg 'Downloading vim-plug'
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echomsg 'Installing vim-plug'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    return v:true
endfun

fun s:user_wants_to(prompt) abort
    let [l:yes, l:no] = [1, 2]
    let l:res = confirm(a:prompt, "&Yes\n&No")
    return l:res == l:yes
endfun
" }}}1

fun s:try_to_get_vim_plug() abort
    if !has('dialog_' . (has('gui_running') ? 'gui' : 'con'))
        " Can't ask if the user wants to get vim-plug; default to no
        return
    endif

    let vim_plug_path = '~/.vim/autoload/plug.vim'
    if get(s:, 'skip_vim_plug_install', v:false)
        " User doesn't want to install vim-plug
        return
    endif
    if kkp#FileExists(vim_plug_path)
        " No need to install
        return
    endif
    if !s:get_vim_plug()
        let l:msg = 'Add the following line at the start of your '
        let l:msg.= 'vimrc to avoid being prompted in the future:'
        let l:msg.= "\n" . 'let s:skip_vim_plug_install = v:true '
        echomsg l:msg
        return
    endif
endfun

call s:try_to_get_vim_plug()
