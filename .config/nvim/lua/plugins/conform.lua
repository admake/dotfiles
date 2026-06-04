return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Безопасно дополняем существующие форматировщики из экстра-пакетов
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        shell = { "shfmt" },
        dockerfile = { "shfmt" },
      })

      -- Кастомизируем конкретный форматировщик
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        shfmt = {
          append_args = { "-i", "2" },
        },
      })
    end,
  },
}
