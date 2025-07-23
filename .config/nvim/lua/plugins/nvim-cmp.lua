require("refactoring").setup({})
require("cmp-npm").setup({})

-- luasnip setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
local compare = require("cmp.config.compare")
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- Move between completion items.
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		-- Scroll text in the documentation window.
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Confirm selection.
		["<C-Space>"] = cmp.mapping.complete(),

		-- Cancel completion.
		["<C-e>"] = cmp.mapping.abort(),

		-- Confirm selection.
		["<CR>"] = cmp.mapping.confirm({
			select = false,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Autocomplete with tab.
		-- If the completion menu is visible, move to the next item.
		-- If the line is "empty", insert a Tab character.
		-- If the cursor is inside a word, trigger the completion menu.
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		-- If the completion menu is visible, move to the previous item.
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{
			name = "nvim_lsp",
			priority = 9,
		},
		{
			name = "luasnip",
			priority = 8,
		},
		{
			name = "treesitter",
			priority = 7,
		},

		-- { name = "parrot", priority = 6 },
		{
			name = "nvim_lsp_signature_help",
			priority = 6,
		},
		{
			name = "path",
			priority = 5,
		},
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
			priority = 4,
		},
		{
			name = "fuzzy_buffer",
			priority = 4,
		},
		{
			name = "npm",
			priority = 4,
			keyword_length = 4,
		},
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			-- compare.score_offset, -- not good at all
			compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
			compare.recently_used,
			compare.locality,
			compare.order,
			compare.offset,
			require("cmp_fuzzy_buffer.compare"),
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				-- ...
				return vim_item
			end,
		}),
	},
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "fuzzy_buffer" },
	}),
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
