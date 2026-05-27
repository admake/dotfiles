return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local lm = require("langmapper")
    lm.setup({
      map_all_ctrl = true,
      -- hack_get_keymap мы вызовем отдельно ниже
    })

    -- Этот хак заставит vim.keymap.set (который мы вызвали в keymaps.lua)
    -- автоматически создать маппинг для русской точки
    lm.hack_get_keymap()
  end,
}
