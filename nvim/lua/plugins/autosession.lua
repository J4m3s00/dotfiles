return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = "info",
			auto_restore = true, -- Automatically restore the session for the current directory on start
			auto_save = true, -- Automatically save the session for the current directory on exit
			auto_create = true, -- Automatically create a new session if one doesn't exist
			auto_delete_empty_session = true, -- Delete session if no buffers are open
			pre_save_cmds = { "Neotree close " },
			post_restore_cmds = { "Neotree filesystem show" },
			-- A list of directories where the session will not be autosaved/autoloaded
			suppressed_dirs = {
				"~/", -- Don't save a session in your home directory
				"~/Downloads",
				"~/Desktop",
				"/tmp",
			},
			-- You can also specify specific filetypes or buftypes to ignore
			autosave_ignore_filetypes = {
				"gitcommit",
				"gitrebase",
				"dashboard",
				"lazy",
				"neo-tree-buffer",
				"NvimTree",
			},
			autosave_ignore_buftypes = { "terminal", "nofile", "prompt", "auto-session-root" },
			-- You can integrate with Telescope if you want a session picker
			-- See auto-session's README for more advanced options like session_lens
			-- and hooks (e.g., to open NvimTree after session load).
			session_lens = {
				load_on_setup = true, -- Initialize on startup (requires Telescope)
				picker_opts = nil, -- Table passed to Telescope / Snacks to configure the picker. See below for more information
				mappings = {
					-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
					copy_session = { "i", "<C-Y>" },
				},

				session_control = {
					control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
					control_filename = "session_control.json", -- File name of the session control file
				},
			},
		})
	end,
}
