vim.wo.relativenumber = true
vim.wo.scrolloff = 5

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[P]Yank to system clipboard" })

-- Git conflict resolution
vim.keymap.set("n", "<leader>go", "<cmd>diffget //2<CR>", { desc = "Git: take ours" })
vim.keymap.set("n", "<leader>gt", "<cmd>diffget //3<CR>", { desc = "Git: take theirs" })
--
-- When you do joins with J it will keep your cursor at the beginning instead of at the end
vim.keymap.set("n", "J", "mzJ`z")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

vim.filetype.add({
	extension = {
		mjml = "mjml",
	},
})

return {
	{
		"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},
		views = {
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					min_width = 60,
					width = "auto",
					height = "auto",
				},
				border = {
					style = "rounded",
				},
			},
		},
		},
	},
	"ec965/mjml-preview.nvim",
	"mattn/emmet-vim",
	{
		"barrett-ruth/live-server.nvim",
		build = "npm add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},
	{
		"delphinus/auto-cursorline.nvim",
		config = function()
			require("auto-cursorline").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
	},
	{
		"lmilojevicc/herdr-splits.nvim",
		-- For local development, swap the repo line for `dir = '/path/to/herdr-splits'`
		-- (see "Local development" below).
		cond = vim.env.HERDR_ENV == "1",
		event = "VeryLazy",
		-- Optional: auto-sync the Herdr-side scripts when lazy updates this plugin.
		-- Requires `auto_sync_herdr = true` in setup() below to take effect.
		-- build = ':lua require("herdr-splits").sync_herdr()',
		config = function()
			require("herdr-splits").setup({
				-- Defaults shown. All fields optional.
				default_amount = 0.03, -- Herdr resize ratio
				neovim_amount = 3, -- Neovim resize cells
				at_edge = "wrap", -- 'wrap' | 'stop' | 'split' | function
				ignored_buftypes = { "nofile", "quickfix", "prompt", "help", "terminal" },
				ignored_filetypes = {
					"NvimTree",
					-- sidebars
					"neo-tree",
					"snacks_dashboard",
					"snacks_explorer",
					"snacks_picker",
					-- DB / REPL / data sidebars
					"dadbod-ui",
					"dbout",
					-- outlines / symbols
					"aerial",
					"Outline",
					-- diagnostics / quick lists
					"Trouble",
					"quickfix",
				},
				move_cursor_same_row = false,
				herdr_bin = nil, -- auto-detected from HERDR_BIN_PATH
				floating_zindex_max = 50, -- floats with zindex < this are treated as embedded sidebars
				ignore_previewwindows = false, -- opt-in: also treat previewwindow windows (e.g. .dbout) as sidebars
				-- auto_sync_herdr = true,      -- opt-in: sync Herdr-side scripts on update
				-- Managed keys — written to the generated herdr-splits.conf so the
				-- Herdr-side scripts agree. Pass Neovim notation (e.g. <M-Left>).
				nav_keys = { left = "<C-h>", down = "<C-j>", up = "<C-k>", right = "<C-l>" },
				resize_keys = { left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>" },
				unzoom_on_nav = true, -- auto-unzoom when navigating away from a zoomed pane
				nav_at_edge = "wrap", -- 'wrap' | 'stop' — Herdr pane-boundary wrap (distinct from at_edge)
			})
		end,
		keys = {
			{
				"<C-h>",
				function()
					require("herdr-splits").move_cursor_left()
				end,
				desc = "Navigate left",
			},
			{
				"<C-j>",
				function()
					require("herdr-splits").move_cursor_down()
				end,
				desc = "Navigate down",
			},
			{
				"<C-k>",
				function()
					require("herdr-splits").move_cursor_up()
				end,
				desc = "Navigate up",
			},
			{
				"<C-l>",
				function()
					require("herdr-splits").move_cursor_right()
				end,
				desc = "Navigate right",
			},
			{
				"<M-h>",
				function()
					require("herdr-splits").resize_left()
				end,
				desc = "Resize left",
			},
			{
				"<M-j>",
				function()
					require("herdr-splits").resize_down()
				end,
				desc = "Resize down",
			},
			{
				"<M-k>",
				function()
					require("herdr-splits").resize_up()
				end,
				desc = "Resize up",
			},
			{
				"<M-l>",
				function()
					require("herdr-splits").resize_right()
				end,
				desc = "Resize right",
			},
		},
	},
	-- {
	-- 	"christoomey/vim-tmux-navigator",
	-- 	keys = {
	-- 		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	-- 		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	-- 		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	-- 		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	-- 		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	-- 	},
	-- },
	-- {
	-- 	"folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	---@type Flash.Config
	-- 	opts = {},
	-- 	--  -- stylua: ignore
	-- 	keys = {
	-- 		{
	-- 			"s",
	-- 			mode = { "n", "x", "o" },
	-- 			function()
	-- 				require("flash").jump()
	-- 			end,
	-- 			desc = "Flash",
	-- 		},
	-- 		{
	-- 			"S",
	-- 			mode = { "n", "x", "o" },
	-- 			function()
	-- 				require("flash").treesitter()
	-- 			end,
	-- 			desc = "Flash Treesitter",
	-- 		},
	-- 		{
	-- 			"r",
	-- 			mode = "o",
	-- 			function()
	-- 				require("flash").remote()
	-- 			end,
	-- 			desc = "Remote Flash",
	-- 		},
	-- 		{
	-- 			"R",
	-- 			mode = { "o", "x" },
	-- 			function()
	-- 				require("flash").treesitter_search()
	-- 			end,
	-- 			desc = "Treesitter Search",
	-- 		},
	-- 		{
	-- 			"<c-s>",
	-- 			mode = { "c" },
	-- 			function()
	-- 				require("flash").toggle()
	-- 			end,
	-- 			desc = "Toggle Flash Search",
	-- 		},
	-- 	},
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)
			require("ibl").setup({
				indent = {
					highlight = highlight,
				},
				scope = {
					enabled = true,
					show_start = true,
				},
			})
		end,
	},
}
