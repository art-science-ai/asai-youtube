return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Add autosave indicator to the statusline
    local function save_status()
      if vim.bo.modified then
        return "●" -- Unsaved changes
      else
        return "✓" -- All saved
      end
    end

    -- Insert the save indicator before the location section
    table.insert(opts.sections.lualine_x, 1, {
      save_status,
      color = function()
        if vim.bo.modified then
          return { fg = "#ed8796" } -- Red for unsaved
        else
          return { fg = "#a6da95" } -- Green for saved
        end
      end,
    })

    return opts
  end,
}
