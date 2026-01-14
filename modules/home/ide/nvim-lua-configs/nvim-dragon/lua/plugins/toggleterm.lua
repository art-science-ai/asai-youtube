-- =====================================================================
-- TOGGLETERM: Terminal management with multiple terminals
-- =====================================================================
--
-- Provides multiple persistent terminals with direction presets
-- Key mappings: <Leader>tt (toggle), <Leader>th (horizontal), <Leader>tv (vertical)
--
-- =====================================================================

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- Terminal configuration
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]], -- Default toggle mapping
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal", -- Default direction
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal mode mappings
    vim.keymap.set('t', [[<Esc><Esc>]], [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    -- Create persistent terminals
    local Terminal = require("toggleterm.terminal").Terminal
    
    local horizontal_term = Terminal:new({ direction = "horizontal", hidden = true })
    local vertical_term = Terminal:new({ direction = "vertical", hidden = true })
    local float_term = Terminal:new({
      direction = "float", 
      hidden = true,
      float_opts = { border = "curved", width = 0.8, height = 0.8 }
    })
    
    -- Key mappings
    vim.keymap.set("n", "<Leader>tt", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("n", "<Leader>th", function() horizontal_term:toggle() end, { desc = "Horizontal terminal" })
    vim.keymap.set("n", "<Leader>tv", function() vertical_term:toggle() end, { desc = "Vertical terminal" })
    vim.keymap.set("n", "<Leader>tf", function() float_term:toggle() end, { desc = "Floating terminal" })
  end,
}
