-- Disable QuickScope when the terminal is in insert mode
term_qs_disable = function ()
	vim.b.qs_reenable = vim.g.qs_enable ~= 0
	if vim.b.qs_reenable then
		vim.cmd 'QuickScopeToggle'
	end
end
term_qs_reenable = function ()
	if vim.b.qs_reenable and vim.g.qs_enable == 0 then
		vim.cmd 'QuickScopeToggle'
	end
	vim.b.qs_reenable = vim.NIL
end
vim.cmd [[
	augroup Terminal
		au!
		au TermOpen * setlocal norelativenumber nonumber
		au TermOpen * au TermEnter <buffer> lua term_qs_disable()
		au TermOpen * au TermLeave <buffer> lua term_qs_reenable()
	augroup END
]]
