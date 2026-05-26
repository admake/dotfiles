return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1000, -- Должен загрузиться раньше всех кеймапов
  config = function()
    local lm = require("langmapper")
    lm.setup({
      -- Автоматически оборачивать vim.keymap.set
      map_all_ctrl = true,
    })
    -- Это "магия", которая заставляет все последующие вызовы vim.keymap.set
    -- (в core/keymaps.lua, lsp/config.lua и т.д.) работать для обеих раскладок
    lm.hack_get_keymap()
  end,
}
