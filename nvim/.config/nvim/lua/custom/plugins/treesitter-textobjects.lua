return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	config = function()
		local textobjects = require("nvim-treesitter-textobjects")
		local select = require("nvim-treesitter-textobjects.select")

		-- Configure text object selection
		textobjects.setup({
			select = {
				-- Automatically jump forward to the next text object
				lookahead = true,

				-- Selection mode for specific captures
				selection_modes = {
					["@parameter.outer"] = "v", -- Characterwise
					["@function.outer"] = "V", -- Linewise
					["@class.outer"] = "<c-v>", -- Blockwise
				},

				-- Include preceding or succeeding whitespace
				include_surrounding_whitespace = true,
			},
		})

		-- Helper for defining text object mappings
		local function map(key, query, description, query_group)
			vim.keymap.set({ "x", "o" }, key, function()
				select.select_textobject(query, query_group or "textobjects")
			end, {
				desc = description,
				silent = true,
			})
		end

		-- Function text objects
		map("af", "@function.outer", "Select outer function")
		map("if", "@function.inner", "Select inner function")

		-- Class/module text objects
		map("ac", "@class.outer", "Select outer class")
		map("ic", "@class.inner", "Select inner part of a class region")

		-- Language scope (locals.scm)
		map("as", "@local.scope", "Select language scope", "locals")
	end,
}
