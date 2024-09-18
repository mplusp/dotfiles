-- Helper function:
-- returns color scheme dependant on operating system theme setting (dark/light)
function color_scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Tokyo Night"
  else
    return "Tokyo Night Day"
  end
end

-- Pull in WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Appearance
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 14.0
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance())
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

-- Keybindings
config.keys = {
  -- Default QuickSelect keybind gets captured by something else on my system
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelect,
  },
  -- Disable some keybinds for 'act.SpawnWindow'
  {
    key = 'N',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- Return config to WezTerm
return config

