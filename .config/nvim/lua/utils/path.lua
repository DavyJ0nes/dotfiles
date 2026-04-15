local M = {}

function M.get_git_root()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
	if vim.v.shell_error == 0 and result[1] then
		return result[1]
	end
	return nil
end

function M.is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
	return vim.v.shell_error == 0
end

return M
