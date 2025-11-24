return {

	-- Required async helper for dap-ui
	{ "nvim-neotest/nvim-nio" },

	-- Core DAP
	{ "mfussenegger/nvim-dap" },

	-- Pretty UI
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},

	-- JS debugger – pinned to working commit (must produce /out directory)
	{
		"microsoft/vscode-js-debug",
		commit = "f4f5802ca4773af80e202f0a2514c9a82f262c82", -- WORKING COMMIT
		build = "npm install --legacy-peer-deps && npm run compile",
	},

	-- Wrapper for vscode-js-debug
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
			"microsoft/vscode-js-debug",
		},
		config = function()
			local dap = require("dap")

			-- Setup JS debug adapter
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
			})

			local js_debugger = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js"

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}

			-- Language configurations
			for _, lang in ipairs({
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			}) do
				dap.configurations[lang] = {

					-- Launch Chrome and attach to Vite/CRA/Next dev server
					{
						name = "Debug with Chrome",
						type = "pwa-chrome",
						request = "launch",
						url = "http://localhost:5173", -- Vite default
						webRoot = "${workspaceFolder}/frontend/src",
						executable = {
							command = "js-debug-adapter",
							args = { "${port}" },
						},
					},

					-- Attach to already-running Chrome with remote-debugging-port
					{
						name = "Attach to Chrome (9222)",
						type = "pwa-chrome",
						request = "attach",
						port = 9222,
						webRoot = "${workspaceFolder}",
					},
				}
			end

			-- Keymaps
			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<Leader>tb", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>du", function()
				require("dapui").toggle()
			end)

			-- Auto-open dap-ui
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
		end,
	},
}
