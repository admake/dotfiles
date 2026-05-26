return {
  "folke/noice.nvim",
  opts = function(_, opts)
    -- Полностью заменяем внешний вид командной строки (cmdline)
    opts.cmdline = {
      enabled = true, -- Включаем кастомную cmdline
      view = "cmdline", -- Меняем вид с "cmdline_popup" на классический снизу
    }
    -- Чтобы и поиск был снизу, тоже включаем его пресет
    opts.presets = opts.presets or {}
    opts.presets.bottom_search = true

    return opts
  end,
}
