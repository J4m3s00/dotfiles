return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup({
			render = "virtual", -- "background", "foreground", or "virtual"
			enable_tailwind = true,
			virtual_symbol_position = "eol",
		})
	end,
}
