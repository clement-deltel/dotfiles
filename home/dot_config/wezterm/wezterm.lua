--------------------------------------------------------------------------------
--               ------- WezTerm Configuration File ------
--------------------------------------------------------------------------------
local wezterm = require 'wezterm'

-- Mux - multiplexer for windows, tabs, and panes inside the terminal
local mux = wezterm.mux
-- Action - perform actions on the terminal
local act = wezterm.action

-- Vars to put things in later
local config = {}
local launch_menu = {}

-- Newer wezterm versions can use the config builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- WSL
local ubuntu_distribution = 'Ubuntu-22.04'

--------------------------------------------------------------------------------
--               ------- General ------
--------------------------------------------------------------------------------

-- Window
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'
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

-- Select
-- config.quick_select_remove_styling = true

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
--               ------- WSL Domains ------
--------------------------------------------------------------------------------
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = ubuntu_distribution,
    username = 'ubuntu',
    default_cwd = '/home/ubuntu',
    default_prog = { 'zsh' }
  },
  {
    name = 'WSL:Kali-Linux',
    distribution = 'kali-linux',
    username = 'kali',
    default_cwd = '/home/kali',
    default_prog = { 'bash' }
  },
}

--------------------------------------------------------------------------------
--               ------- Keyboard ------
--------------------------------------------------------------------------------
config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {
  -- Configuration
  { key = 'R',          mods = 'CTRL|SHIFT',   action = act.ReloadConfiguration },
  -- Domains
  { key = 'w',          mods = 'ALT',          action = act.SpawnTab 'DefaultDomain' },
  { key = 'k',          mods = 'ALT',          action = act.SpawnTab { DomainName = 'WSL:Kali-Linux' } },
  { key = 'u',          mods = 'ALT',          action = act.SpawnTab { DomainName = 'WSL:Ubuntu' } },
  -- Window
  { key = 'N',          mods = 'CTRL|SHIFT',   action = act.SpawnWindow },
  -- Tab - open & close
  { key = 't',          mods = 'ALT',          action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'CTRL',         action = act.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = 'H',          mods = 'LEADER|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'L',          mods = 'LEADER|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'Tab',        mods = 'CTRL',         action = act.ActivateTabRelative(1) },
  { key = 'Tab',        mods = 'CTRL|SHIFT',   action = act.ActivateTabRelative(-1) },
  { key = 'PageUp',     mods = 'SHIFT',         action = act.ActivateTabRelative(-1) },
  { key = 'PageDown',   mods = 'SHIFT',         action = act.ActivateTabRelative(1) },
  -- Tab - move
  { key = 'PageUp',     mods = 'CTRL|SHIFT',   action = act.MoveTabRelative(-1) },
  { key = 'PageDown',   mods = 'CTRL|SHIFT',   action = act.MoveTabRelative(1) },
  -- Pane - split & close
  { key = '\\',         mods = 'LEADER',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-',          mods = 'LEADER',       action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'x',          mods = 'ALT',          action = act.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = 'h',          mods = 'LEADER',       action = act.ActivatePaneDirection 'Left' },
  { key = 'j',          mods = 'LEADER',       action = act.ActivatePaneDirection 'Down' },
  { key = 'k',          mods = 'LEADER',       action = act.ActivatePaneDirection 'Up' },
  { key = 'l',          mods = 'LEADER',       action = act.ActivatePaneDirection 'Right' },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT',   action = act.ActivatePaneDirection 'Right' },
  -- Pane - size
  { key = 'h',          mods = 'CTRL',         action = act.AdjustPaneSize({ 'Left', 5 }) },
  { key = 'j',          mods = 'CTRL',         action = act.AdjustPaneSize({ 'Down', 5 }) },
  { key = 'k',          mods = 'CTRL',         action = act.AdjustPaneSize({ 'Up', 5 }) },
  { key = 'l',          mods = 'CTRL',         action = act.AdjustPaneSize({ 'Right', 5 }) },
  { key = 'H',          mods = 'CTRL|SHIFT',   action = act.AdjustPaneSize({ 'Left', 10 }) },
  { key = 'J',          mods = 'CTRL|SHIFT',   action = act.AdjustPaneSize({ 'Down', 10 }) },
  { key = 'K',          mods = 'CTRL|SHIFT',   action = act.AdjustPaneSize({ 'Up', 10 }) },
  { key = 'L',          mods = 'CTRL|SHIFT',   action = act.AdjustPaneSize({ 'Right', 10 }) },
  { key = 'm',          mods = 'LEADER',       action = act.TogglePaneZoomState },
  { key = 'z',          mods = 'CTRL',         action = act.TogglePaneZoomState },
  { key = 'Z',          mods = 'CTRL|SHIFT',   action = act.TogglePaneZoomState },
  -- Font - size
  { key = '=',          mods = 'CTRL',         action = act.IncreaseFontSize },
  { key = '-',          mods = 'CTRL',         action = act.DecreaseFontSize },
  { key = '0',          mods = 'CTRL',         action = act.ResetFontSize },
  -- Delete
  { key = 'Backspace',  mods = 'CTRL',         action = act.SendKey { key = 'w', mods = 'CTRL' } },
  { key = 'Backspace',  mods = 'CTRL|SHIFT',   action = act.SendKey { key = 'u', mods = 'CTRL' } },
  -- Search
  { key = 'f',          mods = 'CTRL',         action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'F',          mods = 'CTRL|SHIFT',   action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'q',          mods = 'CTRL',         action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'Q',          mods = 'CTRL|SHIFT',   action = act.ClearScrollback 'ScrollbackOnly' },
  -- Select
  { key = 'phys:Space', mods = 'CTRL|SHIFT',   action = act.QuickSelect },
  -- Scroll
  { key = 'g',          mods = 'LEADER',       action = act.ScrollToTop },
  { key = 'G',          mods = 'LEADER|SHIFT', action = act.ScrollToBottom },
  { key = 'PageUp',     mods = 'CTRL',        action = act.ScrollByPage(-1) },
  { key = 'PageDown',   mods = 'CTRL',        action = act.ScrollByPage(1) },
  -- Copy & paste
  { key = 'C',          mods = 'CTRL|SHIFT',   action = act.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'CTRL',         action = act.PasteFrom 'Clipboard' },
  { key = 'V',          mods = 'CTRL|SHIFT',   action = act.PasteFrom 'Clipboard' },
  -- { key = 'p',          mods = 'LEADER',       action = act.PasteFrom 'PrimarySelection', },
  { key = 'x',          mods = 'CTRL',         action = act.ActivateCopyMode },
  { key = 'X',          mods = 'CTRL|SHIFT',   action = act.ActivateCopyMode },
  { key = 'Enter',      mods = 'ALT',          action = act.ActivateCopyMode },
  { key = 'Enter',      mods = 'LEADER',       action = act.ActivateCopyMode },
  -- Command Palette
  { key = 'p',          mods = 'CTRL',         action = act.ActivateCommandPalette },
  { key = 'P',          mods = 'CTRL|SHIFT',   action = act.ActivateCommandPalette },
  -- Emojis
  { key = '.',          mods = 'CTRL',         action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  { key = '.',          mods = 'CTRL|SHIFT',   action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  -- Launcher
  { key = 'l',          mods = 'ALT',          action = act.ShowLauncher },
  -- Other
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
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, } }
}

-- Tmux keybindings compatibility
local tmux_keys = {
  -- Tab - open & close
  { key = 'c',          mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '&',          mods = 'LEADER', action = act.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = 'p',          mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n',          mods = 'LEADER', action = act.ActivateTabRelative(1) },
  -- Pane - close
  { key = 'x',          mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = 'LeftArrow',  mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'DownArrow',  mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  -- Copy & paste
  { key = '[',          mods = 'LEADER', action = act.ActivateCopyMode }
}
for _, keymap in ipairs(tmux_keys) do
  table.insert(config.keys, keymap)
end
-- Add keybindings to activate a specific tab by its number from 1 to 9
for i = 1, 9 do
  table.insert(config.keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
end

-- Key tables
config.key_tables = {
  search_mode = {
    { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'NextMatch' },
    { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'Backspace', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage', },
    { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage', },
    { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  },
}

-- Dead Keys
config.use_dead_keys = false

--------------------------------------------------------------------------------
--               ------- Mouse ------
--------------------------------------------------------------------------------
config.disable_default_mouse_bindings = false
config.mouse_wheel_scrolls_tabs = true
config.mouse_bindings = {
  -- Paste
  { event = { Up = { streak = 1, button = 'Right' } },             mods = 'NONE', action = act.PasteFrom 'Clipboard' },
  -- Select
  { event = { Down = { streak = 2, button = 'Left' } },            mods = 'NONE', action = act.SelectTextAtMouseCursor 'Word' },
  { event = { Down = { streak = 3, button = 'Left' } },            mods = 'NONE', action = act.SelectTextAtMouseCursor 'Line' },
  -- Hyperlinks
  -- Make CTRL-Click open hyperlinks and disable the 'Down' event to avoid weird program behaviors
  { event = { Up = { streak = 1, button = 'Left' } },              mods = 'NONE', action = act.CompleteSelection 'ClipboardAndPrimarySelection' },
  { event = { Up = { streak = 1, button = 'Left' } },              mods = 'CTRL', action = act.OpenLinkAtMouseCursor },
  { event = { Down = { streak = 1, button = 'Left' } },            mods = 'CTRL', action = act.Nop },
  -- Wheel
  -- Scrolling up/down while holding CTRL increases/decreases the font size
  { event = { Down = { streak = 1, button = { WheelUp = 1 } } },   mods = 'CTRL', action = act.IncreaseFontSize },
  { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = 'CTRL', action = act.DecreaseFontSize }
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

  -- First tab: PowerShell with admin privileges in code-win directory
  local tab1, _, window = mux.spawn_window {
    args = args,
    cwd = 'C:\\code-win',
    workspace = 'work'
  }
  tab1:set_title('PowerShell')
  window:gui_window():maximize()

  -- Second tab: WSL Ubuntu in /home/ubuntu directory
  local tab2, _, _ = window:spawn_tab { domain = { DomainName = 'WSL:Ubuntu' } }
  tab2:set_title('WSL Ubuntu')
  tab2:activate()

  mux.set_active_workspace 'work'
end)

return config
