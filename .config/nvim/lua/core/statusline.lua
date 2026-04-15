-- Custom statusline replacing lualine.
-- Highlight groups are defined after the colorscheme loads so colours are correct.

local function define_highlights()
	local hl = vim.api.nvim_set_hl
	hl(0, "SLNormal",  { bg = "#65D1FF", fg = "#112638", bold = true })
	hl(0, "SLInsert",  { bg = "#3EFFDC", fg = "#112638", bold = true })
	hl(0, "SLVisual",  { bg = "#FF61EF", fg = "#112638", bold = true })
	hl(0, "SLCommand", { bg = "#FFDA7B", fg = "#112638", bold = true })
	hl(0, "SLReplace", { bg = "#FF4A4A", fg = "#112638", bold = true })
	hl(0, "SLBase",    { bg = "#191724", fg = "#c3ccdc" })
	hl(0, "SLInactive",{ bg = "#2c3043", fg = "#55607a" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = define_highlights })
define_highlights()

local mode_hl = {
	n  = "%#SLNormal#",
	i  = "%#SLInsert#",
	v  = "%#SLVisual#",
	V  = "%#SLVisual#",
	["\22"] = "%#SLVisual#",
	c  = "%#SLCommand#",
	R  = "%#SLReplace#",
	s  = "%#SLVisual#",
	S  = "%#SLVisual#",
	t  = "%#SLInsert#",
}

local mode_names = {
	n  = "NORMAL",  i = "INSERT",  v = "VISUAL",  V = "V-LINE",
	["\22"] = "V-BLOCK", c = "COMMAND", R = "REPLACE", s = "SELECT",
	S  = "S-LINE",  t = "TERMINAL",
}

function _G.Statusline()
	local m = vim.fn.mode()
	local hl = mode_hl[m] or "%#SLNormal#"
	local name = mode_names[m] or m:upper()

	local parts = {}

	-- mode block
	parts[#parts + 1] = hl .. " " .. name .. " "
	parts[#parts + 1] = "%#SLBase#"

	-- git branch (provided by gitsigns)
	local branch = vim.b.gitsigns_head
	if branch and branch ~= "" then
		parts[#parts + 1] = "  " .. branch
	end

	-- filename
	local fname = vim.fn.expand("%:~:.")
	if fname == "" then fname = "[No Name]" end
	if vim.bo.modified then fname = fname .. " [+]" end
	if vim.bo.readonly then fname = fname .. " [RO]" end
	parts[#parts + 1] = "  " .. fname

	-- right-align everything after this
	parts[#parts + 1] = "%="

	-- diagnostics
	local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	if e > 0 then parts[#parts + 1] = "%#DiagnosticError# " .. e .. " %#SLBase#" end
	if w > 0 then parts[#parts + 1] = "%#DiagnosticWarn# " .. w .. " %#SLBase#" end

	-- active LSP clients
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients > 0 then
		local names = vim.tbl_map(function(c) return c.name end, clients)
		parts[#parts + 1] = "  " .. table.concat(names, ",")
	end

	-- filetype
	local ft = vim.bo.filetype
	if ft ~= "" then
		parts[#parts + 1] = "  " .. ft
	end

	-- location
	parts[#parts + 1] = "  %l:%c "

	return table.concat(parts)
end

vim.opt.statusline = "%!v:lua.Statusline()"
