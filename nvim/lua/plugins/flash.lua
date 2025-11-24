-- This is used for better finding stuff
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<c-t>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
	-- 👇 add this
	config = function(_, opts)
		require("flash").setup(opts)

		-- Explicitly unmap default t/T motions
		vim.keymap.set({ "n", "o", "x" }, "t", "<Nop>")
		vim.keymap.set({ "n", "o", "x" }, "T", "<Nop>")

		-- Now rebind them to Flash
		vim.keymap.set({ "n", "x", "o" }, "t", function()
			require("flash").jump()
		end, { desc = "Flash" })

		vim.keymap.set({ "n", "x", "o" }, "T", function()
			require("flash").treesitter()
		end, { desc = "Flash Treesitter" })
	end,
}
