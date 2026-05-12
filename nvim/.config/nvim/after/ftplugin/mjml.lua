-- Use 2 spaces (common for HTML/MJML)
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true

-- Optional: wrap long attributes nicely
vim.bo.textwidth = 0

-- Prettier command for this buffer
local prettier_cmd = {
	"prettier",
	"--parser",
	"xml",
	"--plugin",
	"@prettier/plugin-xml",
	"--xml-whitespace-sensitivity",
	"ignore",
	"--print-width",
	"100",
}

-- Format current buffer
vim.api.nvim_buf_create_user_command(0, "Format", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

	vim.system(prettier_cmd, {
		stdin = input,
		text = true,
	}, function(obj)
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end

			if obj.code == 0 then
				local lines = vim.split(obj.stdout, "\n", { plain = true })

				-- Avoid adding an extra empty line at EOF
				if lines[#lines] == "" then
					table.remove(lines, #lines)
				end

				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			else
				vim.notify("Prettier failed: " .. obj.stderr, vim.log.levels.ERROR)
			end
		end)
	end)
end, {})
