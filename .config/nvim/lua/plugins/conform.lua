return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff", "black", stop_after_first = true },
        -- Shell-подобные типы файлов
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        shell = { "shfmt" }, -- fallback для прочих shell-скриптов
        dockerfile = { "shfmt" }, -- Dockerfile тоже можно форматировать через shfmt
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Customize formatters
      formatters = {
        shfmt = {
          append_args = { "-i", "2" },
        },
      },
    },
  },
}
