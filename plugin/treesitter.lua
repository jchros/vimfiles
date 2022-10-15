vim.cmd.packadd 'nvim-treesitter'
vim.cmd.packadd 'playground'

require('nvim-treesitter.configs').setup {
	highlight = { enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<S-CR>",
		},
		
	},
	playground = { enable = true }
}

-- The <CR> mapping defined above overrides Vim's mapping for
-- the command-line window, so we need to disable it there.
vim.api.nvim_create_autocmd('CmdwinEnter', { command = 'silent! nunmap <buffer> <CR>' })

require('nvim-treesitter.highlight').set_custom_captures {
	['primitiveType'] = 'Keyword',
	['type.builtin'] = 'Keyword',
	-- Highlighting assignments is useful in languages where the following is true:
	-- 1. assignments are expressions;
	-- 2. assignments can be easily misread as comparisons.
	['assignment'] = 'TSAssignment',
	['vimLiteralKey'] = 'String',
}
