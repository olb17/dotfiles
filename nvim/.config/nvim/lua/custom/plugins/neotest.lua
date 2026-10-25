return {
  {
    "nvim-neotest/neotest",
    ft = { "elixir" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-elixir")({}),
        },
      }
    end,
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "[T]est nearest [R]un", ft = "elixir" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[T]est current [F]ile", ft = "elixir" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[T]est [S]ummary", ft = "elixir" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "[T]est [O]utput", ft = "elixir" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[T]est [O]utput panel", ft = "elixir" },
    },
  },
}
