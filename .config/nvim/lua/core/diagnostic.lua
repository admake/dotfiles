-----------------------------------------------------------
-- Change diagnostic icons
-----------------------------------------------------------

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({
	name = "DiagnosticSignError",
	text = "✘",
})
sign({
	name = "DiagnosticSignWarn",
	text = "▲",
})
sign({
	name = "DiagnosticSignHint",
	text = "⚑",
})
sign({
	name = "DiagnosticSignInfo",
	text = "",
})

-----------------------------------------------------------
-- diagnostic config
-----------------------------------------------------------
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "single" },
	-- virtual_text = false,
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
	-- defaults
	-- {
	--     virtual_text = true,
	--     signs = true,
	--     update_in_insert = false,
	--     underline = true,
	--     severity_sort = false,
	--     float = true
	-- float = {
	--     border = 'rounded',
	--     source = 'always',
	--     header = '',
	--     prefix = ''
	-- }
	-- }
}, neotest_ns)
