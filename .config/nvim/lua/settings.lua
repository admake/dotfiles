local cmd = vim.cmd -- execute Vim commands
local api = vim.api -- execute Vim api
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
g.tagbar_compact = 1
g.tagbar_sort = 0

-- Space Leader
g.mapleader = ' '

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
opt.colorcolumn = '120' -- Разделитель на 80 символов
opt.cursorline = true -- Подсветка строки с курсором
opt.spelllang = { 'en_us', 'ru' } -- Словари рус eng
opt.number = true -- Включаем нумерацию строк
opt.relativenumber = true -- Вкл. относительную нумерацию строк
-- opt.so=999                          -- Курсор всегда в центре экрана
opt.undofile = true -- Возможность отката назад
opt.splitright = true -- vertical split вправо
opt.splitbelow = true -- horizontal split вниз
-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------
opt.termguicolors = true --  24-bit RGB colors
require('onenord').setup()
require('lualine').setup {
    options = {
        theme = 'onenord'
    }
}
-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
-- cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
-- cmd [[
-- autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
-- ]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
-- cmd [[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
-- cmd [[
-- autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
-- ]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)

-----------------------------------------------------------
-- Инициализация плагинов
-----------------------------------------------------------
require 'nvim-tree'.setup()
require('cmp-npm').setup({})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
vim.o.completeopt = 'menuone,noselect'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- luasnip setup
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
-- nvim-cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')
local compare = require('cmp.config.compare')
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        -- Move between completion items.
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        -- Scroll text in the documentation window.
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Confirm selection.
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Cancel completion.
        ['<C-e>'] = cmp.mapping.abort(),

        -- Confirm selection.
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- Autocomplete with tab.
        -- If the completion menu is visible, move to the next item.
        -- If the line is "empty", insert a Tab character.
        -- If the cursor is inside a word, trigger the completion menu.
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        -- If the completion menu is visible, move to the previous item.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' })
    }),
    sources = {
        {
            name = 'nvim_lsp'
        }, {
            name = 'luasnip'
        }, {
            name = 'path'
        }, {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return api.nvim_list_bufs()
                end
            }
        }, {
            name = 'nvim_lsp_signature_help'
        }, {
            name = 'treesitter'
        }, {
            name = 'fuzzy_buffer'
        }, {
            name = 'npm', keyword_length = 4
        },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            require('cmp_fuzzy_buffer.compare'),
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
        }
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end
        })
    }
}
cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
        { name = 'fuzzy_buffer' }
    })
})

require 'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.{yml,yaml}",
                ["https://json.schemastore.org/package.json"] = "package.json"
            },
        },
    }
}
require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
require 'lspconfig'.eslint.setup {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
    quiet = true,
}

-----------------------------------------------------------
-- Change diagnostic icons
-----------------------------------------------------------

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({
    name = 'DiagnosticSignError',
    text = '✘'
})
sign({
    name = 'DiagnosticSignWarn',
    text = '▲'
})
sign({
    name = 'DiagnosticSignHint',
    text = '⚑'
})
sign({
    name = 'DiagnosticSignInfo',
    text = ''
})

-----------------------------------------------------------
-- diagnostic config
-----------------------------------------------------------
vim.diagnostic.config({
    -- virtual_text = false,
    -- severity_sort = true,
    -- float = {
    --     border = 'rounded',
    --     source = 'always',
    --     header = '',
    --     prefix = ''
    -- }
})

-- defaults
-- {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--     underline = true,
--     severity_sort = false,
--     float = true
-- }

-----------------------------------------------------------
-- formatting
-----------------------------------------------------------
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        javascript = { -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = { api.nvim_buf_get_name(0) },
                    stdin = true
                }
            end },
        typescript = { -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = { api.nvim_buf_get_name(0) },
                    stdin = true
                }
            end },
        markdown = { -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = { api.nvim_buf_get_name(0) },
                    stdin = true
                }
            end },
        yaml = { -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = { api.nvim_buf_get_name(0) },
                    stdin = true
                }
            end }
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        -- ["*"] = {
        --     -- "formatter.filetypes.any" defines default configurations for any
        --     -- filetype
        --     require("formatter.filetypes.any").remove_trailing_whitespace
        -- }
    }
}

-- Format on save
local fmtGroup = api.nvim_create_augroup("FormatAutogroup", {
    clear = true
})
api.nvim_create_autocmd("BufWritePost", {
    command = ":FormatWrite",
    group = fmtGroup
})
