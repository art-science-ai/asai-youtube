return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Open yazi file manager",
    },
    {
      "<leader>E",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi in current working directory",
    },
  },
  opts = {
    -- Configuration for yazi.nvim
    open_for_directories = true, -- Open yazi when opening a directory
    keymaps = {
      show_help = "?",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      grep_in_directory = "<c-s>",
      replace_in_directory = "<c-g>",
      cycle_open_buffers = "<tab>",
      copy_relative_path_to_selected_files = "<c-y>",
    },
    -- Integration with smart-splits for navigation
    integrations = {
      grep_in_directory = function(directory)
        require("telescope.builtin").live_grep({ cwd = directory })
      end,
      grep_in_selected_files = function(selected_files)
        require("telescope.builtin").live_grep({ search_dirs = selected_files })
      end,
      resolve_relative_path_application = "",
    },
  },
  config = function(_, opts)
    require("yazi").setup(opts)

    -- Set up smart-splits keymaps for yazi terminal buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "yazi",
      callback = function()
        local smart_splits = require("smart-splits")
        -- Escape terminal mode first, then navigate to keep yazi open
        vim.keymap.set("t", "<c-h>", function()
          vim.cmd("stopinsert")
          smart_splits.move_cursor_left()
        end, { buffer = true, desc = "Move to left split" })
        vim.keymap.set("t", "<c-j>", function()
          vim.cmd("stopinsert")
          smart_splits.move_cursor_down()
        end, { buffer = true, desc = "Move to lower split" })
        vim.keymap.set("t", "<c-k>", function()
          vim.cmd("stopinsert")
          smart_splits.move_cursor_up()
        end, { buffer = true, desc = "Move to upper split" })
        vim.keymap.set("t", "<c-l>", function()
          vim.cmd("stopinsert")
          smart_splits.move_cursor_right()
        end, { buffer = true, desc = "Move to right split" })
      end,
    })
  end,
}
