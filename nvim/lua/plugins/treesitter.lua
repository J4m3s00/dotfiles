return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup({
					opts = {
						enable_close = true,
						enable_rename = true,
						enable_close_on_slash = true,
					},
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- We don't need a separate config block for textobjects if we configure it
			-- directly within the main nvim-treesitter config's opts.
		},
	},
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"rust",
			"typescript",
			"javascript",
			"toml",
			"json",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		autopairs = { enable = true },
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
		folds = { enable = true },
		textobjects = {
			select = {
				enable = true,
				-- You can customize the keymaps for textobject selection here.
				-- For example, `aa` for "around a block", `ia` for "inside a block".
				-- Common ones include:
				-- `ac` (around class), `af` (around function), `al` (around loop), `ai` (around if/conditional)
				-- You can also use `a` for any type of block (though less precise).
				lookahead = true, -- Automatically select the correct textobject type.
				keymaps = {
					-- These are just examples, feel free to modify them.
					-- The default for `nvim-treesitter-textobjects` are usually good.
					-- Try `vaf` (visual around function), `vif` (visual inside function)
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["aa"] = "@parameter.outer", -- A common one for function arguments/parameters
					["ia"] = "@parameter.inner",
					["as"] = "@string.outer",
					["is"] = "@string.inner",
					-- You can add more text objects here. See `:help treesitter-textobjects-doc-selection`
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner", -- Swap current function parameter with the next one
					["<leader>b"] = "@block.outer", -- Swap current block with next (can be complex)
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner", -- Swap current function parameter with the previous one
					["<leader>B"] = "@block.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- Add to jump list
				goto_next_start = {
					["]m"] = "@function.outer", -- Go to start of next function
					["]]"] = "@class.outer", -- Go to start of next class
					["]i"] = "@conditional.outer",
					["]l"] = "@statement.outer",
					["]a"] = "@parameter.outer",
					["]s"] = "@string.outer", -- Go to start of next statement
				},
				goto_next_end = {
					["]M"] = "@function.outer", -- Go to end of next function
					["]["] = "@class.outer", -- Go to end of next class
					["]I"] = "@conditional.outer",
					["]L"] = "@statement.outer",
					["]A"] = "@parameter.outer",
					["]S"] = "@string.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer", -- Go to start of previous function
					["[["] = "@class.outer", -- Go to start of previous class
					["[i"] = "@conditional.outer",
					["[l"] = "@statement.outer",
					["[a"] = "@parameter.outer",
					["[s"] = "@string.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer", -- Go to end of previous function
					["[]"] = "@class.outer", -- Go to end of previous class
					["[I"] = "@conditional.outer",
					["[L"] = "@statement.outer",
					["[A"] = "@parameter.outer",
					["[S"] = "@string.outer",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.opt.foldmethod = "expr"
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
