require("colorful-menu").setup({
	ls = {
		lua_ls = {
			-- Maybe you want to dim arguments a bit.
			arguments_hl = "@comment",
		},
		gopls = {
			-- By default, we render variable/function's type in the right most side,
			-- to make them not to crowd together with the original label.

			-- when true:
			-- foo             *Foo
			-- ast         "go/ast"

			-- when false:
			-- foo *Foo
			-- ast "go/ast"
			align_type_to_right = true,
			-- When true, label for field and variable will format like "foo: Foo"
			-- instead of go's original syntax "foo Foo". If align_type_to_right is
			-- true, this option has no effect.
			add_colon_before_type = false,
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		-- for lsp_config or typescript-tools
		ts_ls = {
			-- false means do not include any extra info,
			-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
			extra_info_hl = "@comment",
		},
		vtsls = {
			-- false means do not include any extra info,
			-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
			extra_info_hl = "@comment",
		},
		["rust-analyzer"] = {
			-- Such as (as Iterator), (use std::io).
			extra_info_hl = "@comment",
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		clangd = {
			-- Such as "From <stdio.h>".
			extra_info_hl = "@comment",
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
			-- the hl group of leading dot of "•std::filesystem::permissions(..)"
			import_dot_hl = "@comment",
			-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
			preserve_type_when_truncate = true,
		},
		zls = {
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
		},
		roslyn = {
			extra_info_hl = "@comment",
		},
		dartls = {
			extra_info_hl = "@comment",
		},
		-- The same applies to pyright/pylance
		basedpyright = {
			-- It is usually import path such as "os"
			extra_info_hl = "@comment",
		},
		pylsp = {
			extra_info_hl = "@comment",
			-- Dim the function argument area, which is the main
			-- difference with pyright.
			arguments_hl = "@comment",
		},
		-- If true, try to highlight "not supported" languages.
		fallback = true,
		-- this will be applied to label description for unsupport languages
		fallback_extra_info_hl = "@comment",
	},
	-- If the built-in logic fails to find a suitable highlight group for a label,
	-- this highlight is applied to the label.
	fallback_highlight = "@variable",
	-- If provided, the plugin truncates the final displayed text to
	-- this width (measured in display cells). Any highlights that extend
	-- beyond the truncation point are ignored. When set to a float
	-- between 0 and 1, it'll be treated as percentage of the width of
	-- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
	-- Default 60.
	max_width = 60,
})

require("blink.cmp").setup(
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	{
		snippets = { preset = "default" },

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "obsidian" },
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
			sorts = {
				"score", -- Primary sort: by fuzzy matching score
				"sort_text", -- Secondary sort: by sortText field if scores are equal
				"label", -- Tertiary sort: by label if still tied
			},
		},
		signature = { enabled = true },
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
			ghost_text = { enabled = true },
			trigger = { show_on_keyword = true, show_on_trigger_character = true },
			list = { selection = { preselect = false, auto_insert = true } },
			menu = {
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
		},

		cmdline = {
			enabled = true,
			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				ghost_text = { enabled = true },
				menu = {
					auto_show = true,
				},
			},
			keymap = {
				preset = "inherit",
				["<CR>"] = { "accept_and_enter", "fallback" },
			},
		},

		keymap = {
			preset = "default",
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				function(ctx)
					if ctx.is_visible then
						return ctx.select_next()
					else
						return false
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				function(ctx)
					if ctx.is_visible then
						return ctx.select_prev()
					else
						return false
					end
				end,
				"fallback",
			},
		},

		-- Иконки
		appearance = {
			kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			},
		},
	}
)
