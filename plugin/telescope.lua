vim.cmd.packadd 'telescope.nvim'
vim.g.pear_tree_ft_disabled = { 'TelescopePrompt' }

vim.api.nvim_set_keymap('n', '<leader>f', '', {
	callback = function ()
		local builtin = require 'telescope.builtin'
		-- If the current buffer belongs in a Git repo, then search
		-- through the files of that repo.  Otherwise, look in the repo
		-- of the current working directory.
		builtin.git_files {
			use_file_path = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';') ~= ''
		}
	end;
})
