if not vim.fn.exists("g:jdtls_path") then
	if not vim.g.warned_about_jdtls_path then
		vim.api.nvim_notify(
			"To enable the Eclipse JDTLS language server, set the g:jdtls_path variable",
			vim.log.levels.WARN, {})
	end
	return
end

if type(vim.g.jdtls_path) ~= 'string' or vim.g.jdtls_path == '' then
	return
end

if not vim.g.equinox_launcher_path then
	local instructions_if_fail = "Please set g:equinox_launcher_path and source ftplugin/java.lua again."
	if not vim.fn.executable("find") or not vim.fn.executable("sort") then
		vim.api.nvim_notify(
			"Couldn't find the Equinox launcher because some basic Unix executables are missing. "
			.. instructions_if_fail,
			vim.log.levels.ERROR, {})
			return
	end

	local equinox_launcher_path = vim.fn.systemlist(string.format(
		"find %s/plugins -type f -name 'org.eclipse.equinox.launcher_*' | sort -Vr",
		vim.g.jdtls_path))

	if #equinox_launcher_path == 0 then
		vim.api.nvim_notify(
			"Could not find the Equinox launcher. " .. instructions_if_fail,
			vim.log.levels.ERROR, {})
	end

	vim.g.equinox_launcher_path = equinox_launcher_path[1]
end

vim.g.jdtls_config_folder = vim.g.jdtls_config_folder or
	string.format("%s/config_%s", vim.g.jdtls_path,
		(vim.fn.has("win32") ~= 0 and "win")
		or (vim.fn.has("mac") ~= 0 and "mac")
		or "linux")

vim.g.jdtls_data_dir = vim.g.jdtls_data_dir or
	vim.env.XDG_DATA_DIR or
	vim.fn.expand(vim.fn.has("win32") ~= 0 and "~/AppData/Local" or "~/.local/share", ":p")

vim.api.nvim_buf_create_user_command(0, "LSPEnable", function(_)
	vim.cmd.packadd('nvim-jdtls')
	vim.b.workspace_data_dir = string.format("%s/jdtls/%s",
		vim.g.jdtls_data_dir,
		vim.fn.fnamemodify(vim.fn.FugitiveFind(":(top)"), ":t"))

	-- Prepending "env --" to the command is needed in Git bash.
	-- It might not be needed in the WSL but I haven't used Java on
	-- Windows for a while so I don't know if this breaks anything.
	local config = {cmd = vim.fn.has('win32') ~= 0 and {"env", "--"} or {}}

	config.cmd = vim.fn.extend(config.cmd, {
		'java';
		'-Declipse.application=org.eclipse.jdt.ls.core.id1';
		'-Dosgi.bundles.defaultStartLevel=4';
		'-Declipse.product=org.eclipse.jdt.ls.core.product';
		'-Dlog.protocol=true';
		'-Dlog.level=ALL';
		'-noverify';
		'-Xmx1G';
		'-jar', vim.g.equinox_launcher_path;
		'-configuration', vim.g.jdtls_config_folder;
		'-data', vim.b.workspace_data_dir;
	})

	require("jdtls").start_or_attach(config)
	end, { desc = "Enables the JDT Language Server.", bar = true })
