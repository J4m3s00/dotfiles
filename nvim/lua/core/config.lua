vim.wo.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.splitright = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "lua", "typescript", "typescriptreact", "javascript", "jsx", "c", "cpp", "python", "json" }, -- Add all filetypes you want Treesitter folding for
	callback = function()
		-- Use vim.opt_local for buffer-local options, or vim.wo for window-local.
		-- foldmethod and foldexpr are typically set as window-local defaults.
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldlevel = 99 -- Optional: keep folds open by default for this filetype
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
