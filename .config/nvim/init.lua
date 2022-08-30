-----------------------------------------------------------
-- Импорт модулей lua
-----------------------------------------------------------
require('plugins')
require('keymaps')
require('settings')
require('auto_dark_mode')

-- require('lspconfig').yamlls.setup {
--   ... -- other configuration for setup {}
--   settings = {
--     yaml = {
--       ... -- other settings. note this overrides the lspconfig defaults.
--       schemas = {
--         ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
--         ["../path/relative/to/file.yml"] = "/.github/workflows/*"
--         ["/path/from/root/of/project"] = "/.github/workflows/*"
--       },
--     },
--   }
-- }

-- local null_ls = require("null-ls")
-- local eslint = require("eslint")

-- null_ls.setup()

-- eslint.setup({
--     bin = 'eslint_d', -- or `eslint`
--     code_actions = {
--         enable = true,
--         apply_on_save = {
--             enable = true,
--             types = {"problem"} -- "directive", "problem", "suggestion", "layout"
--         },
--         disable_rule_comment = {
--             enable = true,
--             location = "separate_line" -- or `same_line`
--         }
--     },
--     diagnostics = {
--         enable = true,
--         report_unused_disable_directives = false,
--         run_on = "type" -- or `save`
--     }
-- })

-- local prettier = require("prettier")

-- prettier.setup({
--     bin = 'prettierd', -- or `prettier`
--     filetypes = {"css", "graphql", "html", "javascript", "javascriptreact", "json", "less", "markdown", "scss",
--                  "typescript", "typescriptreact", "yaml"}
-- })
