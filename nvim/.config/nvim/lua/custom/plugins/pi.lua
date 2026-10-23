-- Copy text to the system clipboard
local function copy_to_clipboard(text)
	vim.fn.setreg("+", text)
	return true, nil
end

-- Copy current file location
vim.api.nvim_create_user_command("CopyLocation", function(opts)
	local name = vim.api.nvim_buf_get_name(0)

	if name == "" then
		vim.notify("CopyLocation: current buffer has no file path", vim.log.levels.ERROR)
		return
	end

	local path = vim.fn.fnamemodify(name, ":p")
	local location

	if opts.range > 0 then
		location = string.format("%s:%d-%d", path, opts.line1, opts.line2)
	else
		local line = vim.api.nvim_win_get_cursor(0)[1]
		location = string.format("%s:%d", path, line)
	end

	local success, err = copy_to_clipboard(location)

	if not success then
		vim.notify("CopyLocation: clipboard copy failed: " .. (err or ""), vim.log.levels.ERROR)
		return
	end

	vim.notify("Copied " .. location)
end, {
	range = true,
	desc = "Copy absolute file location",
})

-- Normal mode: copy current line location
vim.keymap.set("n", "<leader>pc", "<cmd>CopyLocation<CR>", {
	desc = "Copy current location",
})

-- Visual mode: copy selected line range
vim.keymap.set("x", "<leader>pc", ":CopyLocation<CR>", {
	desc = "Copy selected line range",
})

return {}
