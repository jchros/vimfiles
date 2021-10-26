setlocal cc=80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100

" The remainder of this file sets up the Eclipse JDT language server
if !has('nvim')
	finish
endif

if !exists('g:jdtls_path')
	echomsg 'To enable the Eclipse JDT language server, set the g:jdtls_path variable'
	finish
endif

let b:equinox_launcher_path = systemlist(
\	'find '.g:jdtls_path."/plugins -type f -name 'org.eclipse.equinox.launcher_*' | sort -Vr"
\)[0]
if empty(b:equinox_launcher_path)
	echoerr 'Equinox is not available'
	finish
endif

let b:config_folder = g:jdtls_path . '/config_'
if has('win32')
    let b:config_folder .= 'win'
elseif has('mac')
    let b:config_folder .= 'mac'
else
    let b:config_folder .= 'linux'
endif

let b:data_dir = $XDG_DATA_DIR
if empty(b:data_dir)
    let b:data_dir = has('win32') ? '~/AppData/Local/' : '~/.local/share/'
    let b:data_dir = expand(b:data_dir, ':p')
endif

let b:workspace_data_dir = b:data_dir . 'jdtls/' . fnamemodify(FugitiveFind(":(top)"), ":t")

" Prepending 'env --' to the command is needed if you're using Git Bash on
" Windows, make sure that C:\Program Files\Files\Git\usr\bin is in your PATH
let b:config = #{cmd: has('win32') ? ['env', '--'] : []}

let b:config.cmd += [
\	'java',
\	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
\	'-Dosgi.bundles.defaultStartLevel=4',
\	'-Declipse.product=org.eclipse.jdt.ls.core.product',
\	'-Dlog.protocol=true',
\	'-Dlog.level=ALL',
\	'-noverify',
\	'-Xmx1G',
\	'-jar', b:equinox_launcher_path,
\	'-configuration', b:config_folder,
\	'-data', b:workspace_data_dir,
\]

function s:LSPEnable() abort
	lua require('jdtls').start_or_attach(vim.b.config)
endfunction

command -buffer -bar LSPEnable call s:LSPEnable()
