local border = "single"

-- Прямая настройка hover без vim.lsp.with
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config or {}
	config.border = border
	return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- Прямая настройка signatureHelp
vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
	config = config or {}
	config.border = border
	return vim.lsp.handlers.signature_help(_, result, ctx, config)
end
