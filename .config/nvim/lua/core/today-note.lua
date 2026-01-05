local function centered_input(opts, on_confirm)
	local prompt = opts.prompt or ""
	local default = opts.default or ""
	local ui = vim.api.nvim_list_uis()[1]
	local max_width = math.max(20, ui.width - 4)
	local width = math.min(max_width, math.max(40, #prompt + #default + 10))
	local row = math.floor((ui.height - 1) / 2)
	local col = math.floor((ui.width - width) / 2)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.bo[buf].bufhidden = "wipe"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { prompt, default })

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = 2,
		style = "minimal",
		border = "rounded",
	})

	vim.api.nvim_win_set_cursor(win, { 2, #default + 1 })

	local closed = false
	local function finish(text)
		if closed then
			return
		end
		closed = true
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		vim.cmd("stopinsert")
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		on_confirm(text)
	end

	local function read_input()
		local line = vim.api.nvim_buf_get_lines(buf, 1, 2, false)[1]
		return line ~= "" and line or nil
	end

	vim.keymap.set({ "i", "n" }, "<CR>", function()
		finish(read_input())
	end, { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", function()
		finish(nil)
	end, { buffer = buf, silent = true })
	vim.keymap.set("i", "<C-c>", function()
		finish(nil)
	end, { buffer = buf, silent = true })

	vim.cmd("startinsert")
end

local function capture_log_entry()
	-- 1. Configuration: Set your notes directory here
	local notes_dir = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/daily/")
	local date = os.date("%Y-%m-%d")
	local filename = notes_dir .. date .. ".md"

	-- 2. The Input Popup
	centered_input({ prompt = "📝 The Log:" }, function(input)
		if not input or input == "" then
			return
		end

		-- 3. Read the file to find the header
		local lines = {}
		local file = io.open(filename, "r")

		if not file then
			print("No daily note found for today at: " .. filename)
			return
		end

		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()

		-- 4. Find the "## 📝 The Log" section
		local target_header = "## 📝 The Log"
		local insert_at = -1

		for i, line in ipairs(lines) do
			if line:find(target_header, 1, true) then
				insert_at = i
				break
			end
		end

		-- 5. Insert the line below the quote (if present) and after existing bullets
		if insert_at ~= -1 then
			local section_end = #lines + 1
			for i = insert_at + 1, #lines do
				if lines[i]:match("^##%s") then
					section_end = i
					break
				end
			end

			local insert_index = insert_at + 1
			for i = insert_at + 1, section_end - 1 do
				if lines[i]:match("^%s*>") then
					local last_quote = i
					for j = i + 1, section_end - 1 do
						if lines[j]:match("^%s*>") then
							last_quote = j
						else
							break
						end
					end
					insert_index = last_quote + 1
					break
				end
			end

			local last_bullet = nil
			for i = insert_index, section_end - 1 do
				if lines[i]:match("^%s*%- ") then
					last_bullet = i
				end
			end

			if last_bullet then
				insert_index = last_bullet + 1
			end

			table.insert(lines, insert_index, "- " .. input)

			local out_file = io.open(filename, "w")
			for _, line in ipairs(lines) do
				out_file:write(line .. "\n")
			end
			out_file:close()
			print("Logged: " .. input)
		else
			print("Could not find '" .. target_header .. "' in today's note.")
		end
	end)
end

local function nothelp_audit_log()
	-- 1. The Input Popup
	centered_input({ prompt = "⚔️ Time Audit Activity: " }, function(input)
		if not input or input == "" then
			return
		end

		-- 2. Execute the CLI command
		-- We use vim.fn.shellescape to ensure special characters in the input
		-- don't break the shell command.
		local cmd = string.format("nothelp log %s", vim.fn.shellescape(input))

		-- 3. Run it and handle feedback
		local output = vim.fn.system(cmd)

		if vim.v.shell_error ~= 0 then
			vim.notify("Error logging activity: " .. output, vim.log.levels.ERROR)
		else
			vim.notify("Audit Recorded: " .. input, vim.log.levels.INFO)
		end
	end)
end

vim.keymap.set("n", "<leader>nta", nothelp_audit_log, { desc = "[N]note [T]oday [A]udit" })
vim.keymap.set("n", "<leader>ntl", capture_log_entry, { desc = "[N]ote [T]oday [L]og" })
