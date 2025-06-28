-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
local mux = wezterm.mux
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- For example, changing the color scheme:
-- config.color_scheme = 'OneDark (base16)'
config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'BlulocoDark'
-- config.color_scheme = 'MaterialOcean'
-- config.color_scheme = 'Sandcastle (base16)'

-- Do not check for updates
config.check_for_updates = false

-- Custom fond
config.font = wezterm.font('JetBrains Mono',
{italic=false}
)
config.font_size = 13.5

-- Color scheme
config.colors = {
	-- background = '#232326',
	foreground = 'silver',
	cursor_bg = '#52ad70',
}

-- Split panes
config.keys = {
  -- This will create a new split and run the `top` program inside it
  {
    key = 'v',
    mods = 'CTRL|ALT',
    action = act.SplitVertical {domain = 'CurrentPaneDomain'},
    },
  -- This will create a new split and run the `top` program inside it
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal {domain = 'CurrentPaneDomain'},
    }, 
  {
    key = 'x',
    mods = 'CTRL|ALT',
    action = act.CloseCurrentPane{ confirm = false }
    },
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left'
    },
  { 
    key = 'RightArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right'
    },
  { 
    key = 'UpArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up' 
    },
  { 
    key = 'DownArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
    },
  {
    key = 't',
    mods = 'ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(1),
  },
}

-- Hide the tab bar when there is only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Full screen when start up
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
-- and finally, return the configuration to wezterm
return config
