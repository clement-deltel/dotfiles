-- Wezterm Configuration File

-- Mux - mutliplexer for windows etc inside of the terminal
-- Action - perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Vars to put things in later
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- Newer wezterm versions can use the config builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Default Settings

-- Window
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
 }
-- Foreground (text, etc) brighter than background
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}
-- Inactive pane not as saturated and bright as active one
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7
}
-- Color scheme
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Oceanic Next (Gogh)'
-- Font
config.font = wezterm.font('MesloLGM Nerd Font')
config.font_size = 11
-- Cursor blink
config.default_cursor_style = 'BlinkingBar'
config.disable_default_key_bindings = true
-- Scroll
config.scrollback_lines = 100000

-- Keys
config.keys = keys
keys = {
  {
    -- Add the ability to use ctrl+v to paste the system clipboard
    key = 'V',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard'
  },
}
-- Dead Keys
config.use_dead_keys = false

-- Mouse Bindings
config.mouse_bindings = mouse_bindings

-- There are mouse binding to mimic Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

-- Launch Menu
config.launch_menu = launch_menu

-- Workspaces, Windows, Tabs, and Panes
config.default_prog = { 'powershell.exe' }
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu-22.04',
    distribution = 'Ubuntu-22.04',
    username = "ubuntu",
    default_cwd = "/home/ubuntu",
    default_prog = { "zsh" }
  },
}

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  -- First tab: PowerShell with admin privileges in Windows home directory
  local tab1, pane1, window = wezterm.mux.spawn_window {
    args = args,
    cwd = 'C:\\code-win',
    workspace = 'work'
  }
  tab1:set_title('PS1 (admin)')
  window:gui_window():maximize()

  -- Second tab: WSL Ubuntu in home directory
  local tab2, pane2, _ = window:spawn_tab { domain = { DomainName = 'WSL:Ubuntu-22.04' } }
  tab2:set_title('WSL Ubuntu')
  tab2:activate()

  wezterm.mux.set_active_workspace 'work'
end)

return config
