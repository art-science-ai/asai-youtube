-- https://dev.to/lovelindhoni/make-wezterm-mimic-tmux-5893

-- ==================================================================================
-- === Basic config
-- ==================================================================================
-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

-- Platform detection for cross-platform keybinds
local is_macos = wezterm.target_triple:find("darwin") ~= nil
local super_mod = is_macos and "CMD" or "ALT"

-- ==================================================================================
-- === Resurrect plugin (session management)
-- ==================================================================================
-- local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
--
-- -- Save state on window close
-- wezterm.on("window-close-requested", function(window, pane)
-- 	resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
-- 	return true -- Allow the window to close
-- end)
--
-- -- Automatically restore the last session on startup
-- wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

-- ==================================================================================
-- === Bar plugin (status bar - tabline alternative)
-- ==================================================================================
-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config, {
-- 	position = "top",
-- })

-- ==================================================================================
-- === Tabline plugin (tab bar)
-- ==================================================================================
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    -- theme = "Catppuccin Macchiato",
    theme = "rose-pine-moon",
    -- theme = "OneDark (base16)",
  },
  sections = {
    tabline_a = { { "mode", padding = { left = 1, right = 1 } } },
    tabline_b = { { "workspace", padding = { left = 1, right = 1 } } },
    tabline_c = { " || " },
    tab_active = {
      "index",
      { "cwd", padding = { left = 0, right = 1 } },
    },
    tab_inactive = {
      "index",
      { "cwd", padding = { left = 0, right = 1 } },
    },
    -- tabline_x = { 'ram', 'cpu' },
    tabline_x = {  },
    -- tabline_y = { 'datetime', 'battery' },
    tabline_y = {  },
    -- tabline_z = { 'domain' },
    tabline_z = {  },
  },
})
tabline.apply_to_config(config)

-- ==================================================================================
-- === Basic config
-- ==================================================================================
-- This is where you actually apply your config choices.
-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12
config.command_palette_font_size = 12
config.font = wezterm.font("JetBrains Mono")
config.automatically_reload_config = false
-- Removes the macos bar at the top with the 3 buttons and tab bar
config.window_decorations = "NONE"
-- config.enable_tab_bar = false

config.adjust_window_size_when_changing_font_size = false
config.term = "xterm-256color"

-- Allow Option key to work as Alt (important for macOS)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- ==================================================================================
-- === Pane navigation with smart-splits.nvim integration
-- ==================================================================================
local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "ALT" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- Pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "ALT" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

-- ==================================================================================
-- === Keybindings
-- ==================================================================================
config.leader = { key = "d", mods = super_mod, timeout_milliseconds = 2000 }

config.keys = { -- Vim-style pane navigation (CTRL + hjkl) - seamless with smart-splits.nvim
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),

  -- Pane resizing (ALT + hjkl) - seamless with smart-splits.nvim
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),

  -- Leader-based splitting (intuitive directional)
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },
  {
    key = "L", -- Shift + l
    mods = "LEADER",
    action = wezterm.action.SplitPane({
      direction = "Right",
      size = { Percent = 30 },
    }),
  },

  {
    key = "J", -- Shift + j
    mods = "LEADER",
    action = wezterm.action.SplitPane({
      direction = "Down",
      size = { Percent = 20 },
    }),
  },

  {
    key = "m",
    mods = "LEADER",
    -- Super+D then m: maximize/zoom pane
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Super+D then [: enter copy mode
  {
    key = "[",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },

  -- Super+D then c: enter copy mode
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },

  -- Super+D then c: enter copy mode
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },

  -- Disable ALT+Enter (prevents accidental fullscreen)
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },

  -- Super+P: command palette
  {
    key = "P",
    mods = super_mod,
    action = wezterm.action.ActivateCommandPalette,
  },

  -- Super+k: clear screen
  {
    key = "k",
    mods = super_mod,
    action = wezterm.action.Multiple({
      wezterm.action.ClearScrollback("ScrollbackOnly"),
      wezterm.action.SendString("clear\n"),
      -- wezterm.action.ClearScrollback("ScrollbackAndViewport"),
    }),
  },
}

-- Finally, return the configuration to wezterm:
return config
