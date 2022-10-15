local cmp_plugins = vim.fn.split[[
	nvim-cmp
	cmp-buffer
	cmp-omni
	cmp-path
	cmp-vsnip
	cmp-tabnine
]]
for _, plugin in ipairs(cmp_plugins) do vim.cmd.packadd(plugin) end

vim.opt.completeopt = 'menuone,noinsert'

local c = require 'cmp'
local cmp_buffer = require 'cmp_buffer'

-- Function used to determine if autocompletion should
-- be triggered when the tab character is pressed
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

c.setup {
	snippet = {
		expand = function (args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<Tab>"] = c.mapping(function(fallback)
			if c.visible() then
				c.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				c.complete()
			else
				fallback() -- The fallback function sends an already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<C-N>"] = c.mapping(function(fallback)
			if c.visible() then
				c.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-P>"] = c.mapping(function(fallback)
			if c.visible() then
				c.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = c.mapping(function()
			if c.visible() then
				c.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),

		["<CR>"] = c.mapping(c.mapping.confirm { select = true }),
	},
	sources = {
		 { name = 'omni' } ,
		 { name = 'vsnip' } ,
		 { name = 'cmp_tabnine' } ,
		 { name = 'path' } ,
		 { name = 'buffer' } ,
	},
	sorting = {
		comparators = {
			-- Suggest closer words first
			function (...) return cmp_buffer:compare_locality(...) end,
		}
	},
}
