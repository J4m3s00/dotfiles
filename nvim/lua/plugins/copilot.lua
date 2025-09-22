return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "BufWinEnter",
		init = function()
			vim.g.copilot_no_maps = true
		end,
		config = function()
			-- Block the normal Copilot suggestions
			vim.api.nvim_create_augroup("github_copilot", { clear = true })
			vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
				group = "github_copilot",
				callback = function(args)
					vim.fn["copilot#On" .. args.event]()
				end,
			})
			vim.fn["copilot#OnFileType"]()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			debug = true,
			show_help = true,
			window = {
				layout = "float",
				relative = "editor",
				width = 0.5,
				height = 0.65,
				row = 1,
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
		},
	},
}
