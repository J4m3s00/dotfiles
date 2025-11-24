function RunDevAndShow()
	local output = vim.fn.systemlist("npm run dev --silent")
	vim.cmd("enew")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
	vim.bo.filetype = "json"
end

vim.api.nvim_create_user_command("DevOutput", RunDevAndShow, {})
