--------------------------------------------------------------------------------
--               ------- WezTerm Configuration File ------
--------------------------------------------------------------------------------
local wezterm = require 'wezterm'

-- Mux - multiplexer for windows, tabs, and panes inside the terminal
local mux = wezterm.mux
-- Action - perform actions on the terminal
local action = wezterm.action

-- Vars to put things in later
local config = {}
local launch_menu = {}

-- Newer wezterm versions can use the config builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end

--------------------------------------------------------------------------------
--               ------- General ------
--------------------------------------------------------------------------------

-- Window
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
}

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.prefer_to_spawn_tabs = true
config.tab_bar_at_bottom = true
config.tab_max_width = 20
-- config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true

-- Scroll
config.enable_scroll_bar = true
config.scroll_to_bottom_on_input = true
config.scrollback_lines = 100000

-- Security
config.detect_password_input = true

-- Skip close confirmation
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'fish',
  'sh',
  'zsh',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

-- Launch Menu
config.launch_menu = launch_menu

-- Workspaces, Windows, Tabs, and Panes
config.default_prog = { 'powershell.exe' }

--------------------------------------------------------------------------------
--               ------- Domains ------
--------------------------------------------------------------------------------
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu-22.04',
    distribution = 'Ubuntu-22.04',
    username = 'ubuntu',
    default_cwd = '/home/ubuntu',
    default_prog = { 'zsh' }
  },
}

--------------------------------------------------------------------------------
--               ------- Keyboard ------
--------------------------------------------------------------------------------
config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {
  -- Configuration
  { key = 'R',          mods = 'CTRL|SHIFT',   action = action.ReloadConfiguration },
  -- Window
  { key = 'N',          mods = 'CTRL|SHIFT',   action = action.SpawnWindow },
  -- Tab - open & close
  { key = 't',          mods = 'ALT',          action = action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'ALT',          action = action.SpawnTab 'DefaultDomain' },
  { key = 'l',          mods = 'ALT',          action = action.SpawnTab { DomainName = 'WSL:Ubuntu-22.04' } },
  { key = 'w',          mods = 'CTRL',         action = action.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = 'H',          mods = 'LEADER|SHIFT', action = action.ActivateTabRelative(-1) },
  { key = 'L',          mods = 'LEADER|SHIFT', action = action.ActivateTabRelative(1) },
  { key = 'PageUp',     mods = 'CTRL',         action = action.ActivateTabRelative(-1) },
  { key = 'PageDown',   mods = 'CTRL',         action = action.ActivateTabRelative(1) },
  -- Pane - split & close
  { key = '\\',         mods = 'LEADER',       action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-',          mods = 'LEADER',       action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'x',          mods = 'ALT',          action = action.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = 'h',          mods = 'LEADER',       action = action.ActivatePaneDirection 'Left' },
  { key = 'j',          mods = 'LEADER',       action = action.ActivatePaneDirection 'Down' },
  { key = 'k',          mods = 'LEADER',       action = action.ActivatePaneDirection 'Up' },
  { key = 'l',          mods = 'LEADER',       action = action.ActivatePaneDirection 'Right' },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT',   action = action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT',   action = action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT',   action = action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT',   action = action.ActivatePaneDirection 'Right' },
  -- Pane - size
  { key = 'h',          mods = 'CTRL',         action = action.AdjustPaneSize({ 'Left', 5 }) },
  { key = 'j',          mods = 'CTRL',         action = action.AdjustPaneSize({ 'Down', 5 }) },
  { key = 'k',          mods = 'CTRL',         action = action.AdjustPaneSize({ 'Up', 5 }) },
  { key = 'l',          mods = 'CTRL',         action = action.AdjustPaneSize({ 'Right', 5 }) },
  { key = 'H',          mods = 'CTRL|SHIFT',   action = action.AdjustPaneSize({ 'Left', 10 }) },
  { key = 'J',          mods = 'CTRL|SHIFT',   action = action.AdjustPaneSize({ 'Down', 10 }) },
  { key = 'K',          mods = 'CTRL|SHIFT',   action = action.AdjustPaneSize({ 'Up', 10 }) },
  { key = 'L',          mods = 'CTRL|SHIFT',   action = action.AdjustPaneSize({ 'Right', 10 }) },
  { key = 'm',          mods = 'LEADER',       action = action.TogglePaneZoomState },
  -- Font - size
  { key = '+',          mods = 'CTRL',         action = action.IncreaseFontSize },
  { key = '-',          mods = 'CTRL',         action = action.DecreaseFontSize },
  { key = '0',          mods = 'CTRL',         action = action.ResetFontSize },
  -- Scroll
  { key = 'g',          mods = 'LEADER',       action = action.ScrollToTop },
  { key = 'G',          mods = 'LEADER|SHIFT', action = action.ScrollToBottom },
  -- Copy & paste
  -- { key = 'C',          mods = 'CTRL|SHIFT',   action = action.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'ALT',          action = action.PasteFrom 'Clipboard' },
  -- { key = 'p',          mods = 'LEADER',       action = action.PasteFrom 'PrimarySelection', },
  { key = 'Enter',      mods = 'ALT',          action = action.ActivateCopyMode },
  { key = 'Enter',      mods = 'LEADER',       action = action.ActivateCopyMode },
  -- Other
  { key = 'U',          mods = 'CTRL|SHIFT',   action = action.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  { key = 'b',          mods = 'CTRL|LEADER',  action = action.SendString '\x02', },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = action.Multiple
        {
          action.ClearScrollback 'ScrollbackAndViewport',
          action.SendKey { key = 'L', mods = 'CTRL' }
        }
  },
  { key = 'r', mods = 'LEADER', action = action.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, }
}

-- Tmux keybindings compatibility
local tmux_keys = {
  -- Tab - open & close
  { key = 'c',          mods = 'LEADER', action = action.SpawnTab 'CurrentPaneDomain' },
  { key = '&',          mods = 'LEADER', action = action.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = 'p',          mods = 'LEADER', action = action.ActivateTabRelative(-1) },
  { key = 'n',          mods = 'LEADER', action = action.ActivateTabRelative(1) },
  -- Pane - close
  { key = 'x',          mods = 'LEADER', action = action.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = 'LeftArrow',  mods = 'LEADER', action = action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'LEADER', action = action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'LEADER', action = action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'LEADER', action = action.ActivatePaneDirection 'Right' },
}
for _, keymap in ipairs(tmux_keys) do
  table.insert(config.keys, keymap)
end
-- Add keybindings to activate a specific tab by its number from 1 to 9
for i = 1, 9 do
  table.insert(config.keys, { key = tostring(i), mods = "LEADER", action = action.ActivateTab(i - 1) })
end

-- Dead Keys
config.use_dead_keys = false

--------------------------------------------------------------------------------
--               ------- Mouse ------
--------------------------------------------------------------------------------
config.mouse_wheel_scrolls_tabs = true
config.mouse_bindings = {
  -- Change the default click behavior so that it does not open hyperlinks
  -- Make CTRL-Click open hyperlinks
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = action.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = action.Nop,
  },

  -- Scrolling up/down while holding CTRL increases/decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = action.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = action.DecreaseFontSize,
  },

  -- Mimic Windows Terminal and let you copy
  -- To copy just highlight something and right click. Simple
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(action.CopyTo('ClipboardAndPrimarySelection'), pane)
        window:perform_action(action.ClearSelection, pane)
      else
        window:perform_action(action({ PasteFrom = 'Clipboard' }), pane)
      end
    end),
  },
}

--------------------------------------------------------------------------------
--               ------- Theme ------
--------------------------------------------------------------------------------

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

-- Scheme
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Oceanic Next (Gogh)'

-- Font
config.font = wezterm.font('MesloLGM Nerd Font')
config.font_size = 11

-- Cursor
config.default_cursor_style = 'SteadyBlock'

--------------------------------------------------------------------------------
--               ------- Startup ------
--------------------------------------------------------------------------------
wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  -- First tab: PowerShell with admin privileges in Windows home directory
  local tab1, _, window = mux.spawn_window {
    args = args,
    cwd = 'C:\\code-win',
    workspace = 'work'
  }
  tab1:set_title('PowerShell (admin)')
  window:gui_window():maximize()

  -- Second tab: WSL Ubuntu in home directory
  local tab2, _, _ = window:spawn_tab { domain = { DomainName = 'WSL:Ubuntu-22.04' } }
  tab2:set_title('WSL Ubuntu'):activate()

  mux.set_active_workspace 'work'
end)

return config
