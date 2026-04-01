vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackStatus", function()
	vim.pack.update(nil, { offline = true })
end, {})
