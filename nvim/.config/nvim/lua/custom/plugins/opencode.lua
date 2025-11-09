return {
	"github/copilot.vim",
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- uncomment the following line to load hub lazily
		--cmd = "MCPHub",  -- lazy load
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup()
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for default `toggle()` implementation.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.auto_reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "x" }, "ga", function()
				require("opencode").prompt("@this")
			end, { desc = "Add to opencode" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })
			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
}
