vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Luôn tạo buffer mới để tránh lỗi và tránh reuse buffer cũ (tránh bug với terminal)
	local buf = vim.api.nvim_create_buf(false, true)

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local function open_terminal_if_needed()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window()
		-- Tạo terminal trực tiếp trên buffer vừa tạo, không tạo thêm tab mới
		local shell = vim.o.shell or os.getenv("SHELL") or "/bin/sh"
		vim.fn.termopen(shell)
		vim.api.nvim_buf_set_option(state.floating.buf, "bufhidden", "wipe")
		vim.cmd("startinsert")
	end
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		open_terminal_if_needed()
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set({ "n", "t" }, "<leader>t", toggle_terminal, { desc = "Toggle floating terminal" })

vim.keymap.set({ "n", "t" }, "<leader>q", function()
	if vim.api.nvim_win_is_valid(state.floating.win) then
		vim.api.nvim_win_hide(state.floating.win)
	end
end, { desc = "Close floating terminal" })

local function run_current_file()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e")
	local cmd = nil
	if ext == "py" then
		cmd = "python3 " .. file
	elseif ext == "js" then
		cmd = "node " .. file
	elseif ext == "ts" then
		cmd = "ts-node " .. file
	elseif ext == "c" then
		cmd = "gcc " .. file .. " -o /tmp/a.out && /tmp/a.out"
	else
		print("Không hỗ trợ file ." .. ext)
		return
	end

	open_terminal_if_needed()

	if vim.api.nvim_win_is_valid(state.floating.win) and vim.api.nvim_buf_is_valid(state.floating.buf) then
		local ok, _ = pcall(function()
			vim.api.nvim_set_current_win(state.floating.win)
			vim.cmd("startinsert")
			-- Lấy job_id của terminal buffer hiện tại (phải đúng buffer!)
			local bufnr = state.floating.buf
			local job = vim.b[bufnr] and vim.b[bufnr].terminal_job_id or nil
			if job then
				vim.fn.chansend(job, cmd .. "\n")
			else
				print("Không tìm thấy terminal job_id")
			end
		end)
		if not ok then
			print("Không gửi được lệnh vào terminal.")
		end
	else
		print("Terminal nổi chưa mở!")
	end
end

vim.keymap.set("n", "<F6>", run_current_file, { desc = "Run current file in floating terminal" })
