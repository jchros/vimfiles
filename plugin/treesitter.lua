vim.cmd.packadd 'nvim-treesitter'
vim.cmd.packadd 'playground'

require('nvim-treesitter.configs').setup {
	highlight = { enable = true,
		additional_vim_regex_highlighting = false,
		disable = function (lang, buf)
			local max_filesize = 2000 * 1000 -- 2000 KB (2 MB)
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	incremental_selection = { enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<S-CR>",
		},
		
	},
	playground = { enable = true },
}

local id = vim.api.nvim_create_augroup("treesitter", {})

-- The <CR> mapping defined above overrides Vim's mapping for
-- the command-line window, so we need to disable it there.
vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = "treesitter",
	command = "silent! nunmap <buffer> <CR>"
})

vim.cmd.hi{'def', 'link', '@type.builtin', 'Keyword'}
-- Highlighting assignments is useful in languages where the following is true:
-- 1. assignments are expressions;
-- 2. assignments can be easily misread as comparisons.
vim.cmd.hi{'def', 'link', '@assignment', 'TSAssignment'}
