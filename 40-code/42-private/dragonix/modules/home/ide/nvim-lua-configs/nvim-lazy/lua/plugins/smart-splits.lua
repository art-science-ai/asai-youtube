return {
  "mrjones2014/smart-splits.nvim",
  version = ">=1.0.0",
  lazy = false,
  keys = {
    -- Moving between splits
    { "<c-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    { "<c-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to lower split" },
    { "<c-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to upper split" },
    { "<c-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    -- Resizing splits
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    -- Swapping buffers between windows
    { "<leader>sh", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
    { "<leader>sj", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
    { "<leader>sk", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
    { "<leader>sl", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
  },
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "prompt" },
    ignored_buftypes = { "NvimTree" },
    default_amount = 3,
    at_edge = "wrap",
    move_cursor_same_row = false,
  },
}
