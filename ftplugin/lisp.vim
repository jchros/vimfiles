setlocal tabstop=2 shiftwidth=2 expandtab
command -bang -buffer LSPEnable call vlime#server#New(v:true, <bang>v:false)
