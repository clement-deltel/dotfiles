-- Wezterm Configuration File

-- Mux - mutliplexer for windows etc inside of the terminal
-- Action - perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Vars to put things in later
local config = {}
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
-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.prefer_to_spawn_tabs = true
--config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true
-- Foreground brighter than background
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
-- Cursor
config.default_cursor_style = 'SteadyBlock'
-- Scroll
config.enable_scroll_bar = true
config.scroll_to_bottom_on_input = true
config.scrollback_lines = 100000
-- Security
config.detect_password_input = true
-- Skip close confirmation
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

-- Keys
config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {
  -- Split
  { key = '-',          mods = 'LEADER',          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '\\',          mods = 'LEADER',          action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  -- Spawn tab & window
  { key = 't',          mods = 'ALT',          action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n',          mods = 'CTRL|SHIFT',   action = act.SpawnWindow },
  -- Activate tab & pane
  { key = 'h',          mods = 'SUPER|SHIFT',    action = act.ActivateTabRelative(-1) },
  { key = 'h',          mods = 'SUPER',          action = act.ActivatePaneDirection 'Left', },
  { key = 'j',          mods = 'SUPER',          action = act.ActivatePaneDirection 'Down', },
  { key = 'k',          mods = 'SUPER',          action = act.ActivatePaneDirection 'Up', },
  { key = 'l',          mods = 'SUPER',          action = act.ActivatePaneDirection 'Right', },
  { key = 'l',          mods = 'SUPER|SHIFT',    action = act.ActivateTabRelative(1) },
  { key = 'PageUp',     mods = 'CTRL',         action = act.ActivateTabRelative(-1) },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Right' },
  { key = 'PageDown',   mods = 'CTRL',         action = act.ActivateTabRelative(1) },
  -- Close tab & pane
  { key = 'w',          mods = 'ALT',          action = act.CloseCurrentTab { confirm = false } },
  { key = 'x',          mods = 'ALT',          action = act.CloseCurrentPane { confirm = false } },
  -- Copy & paste
  { key = 'C',          mods = 'CTRL|SHIFT',   action = act.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'ALT',          action = act.PasteFrom 'Clipboard' },
  { key = 'p',          mods = 'LEADER',       action = act.PasteFrom 'PrimarySelection', },
  { key = 'Enter',      mods = 'ALT',          action = act.ActivateCopyMode },
  { key = 'Enter',      mods = 'LEADER',       action = act.ActivateCopyMode, },
  -- Font size
  { key = '+',          mods = 'CTRL',         action = act.IncreaseFontSize },
  { key = '-',          mods = 'CTRL',         action = act.DecreaseFontSize },
  { key = '0',          mods = 'CTRL',         action = act.ResetFontSize },
  { key = 'R',          mods = 'CTRL|SHIFT',   action = act.ReloadConfiguration },
  -- Scroll
  { key = 'g',          mods = 'LEADER',       action = act.ScrollToTop },
  { key = 'G',          mods = 'LEADER|SHIFT', action = act.ScrollToBottom },
  -- Other
  { key = 'U',          mods = 'CTRL|SHIFT',   action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  { key = 'b',          mods = 'CTRL|LEADER',  action = act.SendString '\x02', },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.Multiple
        {
          act.ClearScrollback 'ScrollbackAndViewport',
          act.SendKey { key = 'L', mods = 'CTRL' }
        }
  },
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, }
}
-- Dead Keys
config.use_dead_keys = false

-- Mouse
config.mouse_wheel_scrolls_tabs = true
config.mouse_bindings = {
  -- Change the default click behavior so that it does not open hyperlinks
  -- Make CTRL-Click open hyperlinks
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.Nop,
  },

  -- Scrolling up/down while holding CTRL increases/decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },

  -- Mimic Windows Terminal and let you copy
  -- To copy just highlight something and right click. Simple
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(act.CopyTo('ClipboardAndPrimarySelection'), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = 'Clipboard' }), pane)
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
    username = 'ubuntu',
    default_cwd = '/home/ubuntu',
    default_prog = { 'zsh' }
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
  local tab1, _, window = wezterm.mux.spawn_window {
    args = args,
    cwd = 'C:\\code-win',
    workspace = 'work'
  }
  tab1:set_title('PS1 (admin)')
  window:gui_window():maximize()

  -- Second tab: WSL Ubuntu in home directory
  local tab2, _, _ = window:spawn_tab { domain = { DomainName = 'WSL:Ubuntu-22.04' } }
  tab2:set_title('WSL Ubuntu')
  tab2:activate()

  wezterm.mux.set_active_workspace 'work'
end)

return config
