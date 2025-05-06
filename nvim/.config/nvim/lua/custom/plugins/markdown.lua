return {
	{
		"bullets-vim/bullets.vim",
		config = function()
			-- Disable deleting the last empty bullet when pressing <cr> or 'o'
			-- default = 1
			vim.g.bullets_delete_last_bullet_if_empty = 1

			-- (Optional) Add other configurations here
			-- For example, enabling/disabling mappings
			-- vim.g.bullets_set_mappings = 1
		end,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			symbol_folding = {
				-- Unfold entire symbol tree by default with false, otherwise enter a
				-- number starting from 1
				autofold_depth = false,
				-- autofold_depth = 1,
			},
		},
	},
	{
		-- run before launch, once, :Lazy build markdown-preview.nvim
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		ft = { "markdown", "codecompanion" },
		build = function()
			vim.cmd([[Lazy load markdown-preview.nvim]])
			vim.fn["mkdp#util#install"]()
		end,
	},
}
