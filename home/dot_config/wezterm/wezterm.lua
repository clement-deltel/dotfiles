--------------------------------------------------------------------------------
--               ------- WezTerm Configuration File ------
--------------------------------------------------------------------------------
-- List of plugins: https://github.com/michaelbrusegard/awesome-wezterm
-- List of themes: https://wezfurlong.org/wezterm/colorschemes/index.html

-- Enable debug logs
-- $env:WEZTERM_LOG="debug"

-- Clone plugin repositories locally and use file URI if experiencing network issues
-- git clone ${REPOSITORY_URL} ${HOME}/.local/share/wezterm/plugins/
-- local ${PLUGIN} = wezterm.plugin.require("file:///${HOME}/.local/share/wezterm/plugins/{REPOSITORY_NAME}")


local wezterm = require "wezterm"

-- Mux - multiplexer for windows, tabs, and panes inside the terminal
local mux = wezterm.mux
-- Action - perform actions on the terminal
local act = wezterm.action

-- Vars to put things in later
local config = {}

-- Newer wezterm versions can use the config builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Color Theme
-- Tested so far: AdventureTime, Ubuntu
local default_theme = "Oceanic Next (Gogh)"
local tabline_theme = "Catppuccin Mocha"

-- WSL
local ubuntu_distribution = "Ubuntu-22.04"

--------------------------------------------------------------------------------
--               ------- General ------
--------------------------------------------------------------------------------

-- Window
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_frame = {
  font = wezterm.font { family = "Noto Sans", weight = "Regular" },
}

-- Tab
config.hide_tab_bar_if_only_one_tab = false
config.prefer_to_spawn_tabs = true
config.tab_bar_at_bottom = true
config.tab_max_width = 20
-- config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true

-- Refresh
config.status_update_interval = 1000

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
  "bash",
  "fish",
  "sh",
  "zsh",
  "tmux",
  "nu",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
}

--------------------------------------------------------------------------------
--               ------- Keyboard ------
--------------------------------------------------------------------------------
config.disable_default_key_bindings = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  -- Configuration
  { key = "R",          mods = "CTRL|SHIFT",   action = act.ReloadConfiguration },
  -- Application
  { key = "q",          mods = "CTRL",         action = act.QuitApplication },
  -- Window
  { key = "N",          mods = "CTRL|SHIFT",   action = act.SpawnWindow },
  -- Workspaces - activate
  { key = "[",          mods = "CTRL",         action = act.SwitchWorkspaceRelative(-1) },
  { key = "]",          mods = "CTRL",         action = act.SwitchWorkspaceRelative(1) },
  -- Tab - open & close
  { key = "t",          mods = "ALT",          action = act.SpawnTab "CurrentPaneDomain" },
  { key = "w",          mods = "CTRL",         action = act.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = "Tab",        mods = "CTRL",         action = act.ActivateTabRelative(1) },
  { key = "Tab",        mods = "CTRL|SHIFT",   action = act.ActivateTabRelative(-1) },
  -- Tab - move
  { key = "PageUp",     mods = "CTRL|SHIFT",   action = act.MoveTabRelative(-1) },
  { key = "PageDown",   mods = "CTRL|SHIFT",   action = act.MoveTabRelative(1) },
  -- Pane - split & close
  { key = "\\",         mods = "LEADER|CTRL",  action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "-",          mods = "LEADER|CTRL",  action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "x",          mods = "ALT",          action = act.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = "H",          mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Left" },
  { key = "J",          mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Down" },
  { key = "K",          mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Up" },
  { key = "L",          mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Right" },
  { key = "LeftArrow",  mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Left" },
  { key = "DownArrow",  mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Down" },
  { key = "UpArrow",    mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Up" },
  { key = "RightArrow", mods = "CTRL|SHIFT",   action = act.ActivatePaneDirection "Right" },
  -- Pane - size
  { key = "h",          mods = "CTRL",         action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "j",          mods = "CTRL",         action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "k",          mods = "CTRL",         action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "l",          mods = "CTRL",         action = act.AdjustPaneSize({ "Right", 5 }) },
  { key = "h",          mods = "ALT",          action = act.AdjustPaneSize({ "Left", 10 }) },
  { key = "j",          mods = "ALT",          action = act.AdjustPaneSize({ "Down", 10 }) },
  { key = "k",          mods = "ALT",          action = act.AdjustPaneSize({ "Up", 10 }) },
  { key = "l",          mods = "ALT",          action = act.AdjustPaneSize({ "Right", 10 }) },
  { key = "m",          mods = "LEADER",       action = act.TogglePaneZoomState },
  { key = "z",          mods = "ALT",          action = act.TogglePaneZoomState },
  -- Font - size
  { key = "=",          mods = "CTRL",         action = act.IncreaseFontSize },
  { key = "-",          mods = "CTRL",         action = act.DecreaseFontSize },
  { key = "0",          mods = "CTRL",         action = act.ResetFontSize },
  -- Debug
  { key = 'd',          mods = 'ALT',          action = wezterm.action.ShowDebugOverlay },
  -- Delete
  { key = "Backspace",  mods = "CTRL",         action = act.SendKey { key = "w", mods = "CTRL" } }, --word
  { key = "Backspace",  mods = "CTRL|SHIFT",   action = act.SendKey { key = "u", mods = "CTRL" } }, --line
  -- Search
  { key = "f",          mods = "CTRL",         action = act.Search "CurrentSelectionOrEmptyString" },
  { key = "F",          mods = "CTRL|SHIFT",   action = act.Search "CurrentSelectionOrEmptyString" },
  { key = "b",          mods = "CTRL",         action = act.ClearScrollback "ScrollbackOnly" },
  { key = "B",          mods = "CTRL|SHIFT",   action = act.ClearScrollback "ScrollbackOnly" },
  -- Select
  { key = "phys:Space", mods = "CTRL|SHIFT",   action = act.QuickSelect },
  -- Scroll
  { key = "g",          mods = "LEADER",       action = act.ScrollToTop },
  { key = "G",          mods = "LEADER|SHIFT", action = act.ScrollToBottom },
  { key = "PageUp",     mods = "CTRL",         action = act.ScrollByPage(-1) },
  { key = "PageDown",   mods = "CTRL",         action = act.ScrollByPage(1) },
  -- Copy & paste
  { key = "C",          mods = "CTRL|SHIFT",   action = act.CopyTo "Clipboard" },
  { key = "v",          mods = "CTRL",         action = act.PasteFrom "Clipboard" },
  { key = "V",          mods = "CTRL|SHIFT",   action = act.PasteFrom "Clipboard" },
  -- { key = "p",          mods = "LEADER",       action = act.PasteFrom "PrimarySelection", },
  { key = "x",          mods = "CTRL",         action = act.ActivateCopyMode },
  { key = "X",          mods = "CTRL|SHIFT",   action = act.ActivateCopyMode },
  { key = "Enter",      mods = "ALT",          action = act.ActivateCopyMode },
  { key = "Enter",      mods = "LEADER",       action = act.ActivateCopyMode },
  -- Launcher & Command Palette
  { key = "p",          mods = "CTRL",         action = act.ShowLauncher },
  { key = "P",          mods = "CTRL|SHIFT",   action = act.ActivateCommandPalette },
  -- Emojis
  { key = ".",          mods = "CTRL",         action = act.CharSelect { copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" } },
  -- Comment and skip command
  {
    key = "q",
    mods = "LEADER",
    action = act.Multiple {
      act.SendKey { key = "A", mods = "CTRL" }, act.SendKey { key = "#" }, act.SendKey { key = "Enter" } }
  },
  -- Other
  { key = "b", mods = "CTRL|LEADER", action = act.SendString "\x02", },
  {
    key = "k",
    mods = "CTRL|ALT",
    action = act.Multiple
        {
          act.ClearScrollback "ScrollbackAndViewport",
          act.SendKey { key = "L", mods = "CTRL" }
        }
  },
  { key = "r", mods = "ALT",         action = act.ActivateKeyTable { name = "resize_pane", one_shot = false, } }
}

-- Tmux keybindings compatibility
local tmux_keys = {
  -- Tab - open & close
  { key = "c",          mods = "LEADER", action = act.SpawnTab "CurrentPaneDomain" },
  { key = "&",          mods = "LEADER", action = act.CloseCurrentTab { confirm = false } },
  -- Tab - activate
  { key = "p",          mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "n",          mods = "LEADER", action = act.ActivateTabRelative(1) },
  -- Pane - close
  { key = "x",          mods = "LEADER", action = act.CloseCurrentPane { confirm = false } },
  -- Pane - activate
  { key = "LeftArrow",  mods = "LEADER", action = act.ActivatePaneDirection "Left" },
  { key = "DownArrow",  mods = "LEADER", action = act.ActivatePaneDirection "Down" },
  { key = "UpArrow",    mods = "LEADER", action = act.ActivatePaneDirection "Up" },
  { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection "Right" },
  -- Copy & paste
  { key = "[",          mods = "LEADER", action = act.ActivateCopyMode }
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
    { key = "Enter",     mods = "NONE", action = act.CopyMode "NextMatch" },
    { key = "Escape",    mods = "NONE", action = act.CopyMode "Close" },
    { key = "n",         mods = "CTRL", action = act.CopyMode "NextMatch" },
    { key = "p",         mods = "CTRL", action = act.CopyMode "PriorMatch" },
    { key = "r",         mods = "CTRL", action = act.CopyMode "CycleMatchType" },
    { key = "u",         mods = "CTRL", action = act.CopyMode "ClearPattern" },
    { key = "Backspace", mods = "CTRL", action = act.CopyMode "ClearPattern" },
    { key = "PageUp",    mods = "NONE", action = act.CopyMode "PriorMatchPage", },
    { key = "PageDown",  mods = "NONE", action = act.CopyMode "NextMatchPage", },
    { key = "UpArrow",   mods = "NONE", action = act.CopyMode "PriorMatch" },
    { key = "DownArrow", mods = "NONE", action = act.CopyMode "NextMatch" },
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
  { event = { Up = { streak = 1, button = "Right" } },             mods = "NONE", action = act.PasteFrom "Clipboard" },
  -- Select
  { event = { Down = { streak = 2, button = "Left" } },            mods = "NONE", action = act.SelectTextAtMouseCursor "Word" },
  { event = { Down = { streak = 3, button = "Left" } },            mods = "NONE", action = act.SelectTextAtMouseCursor "Line" },
  -- Hyperlinks
  -- Make CTRL-Click open hyperlinks and disable the "Down" event to avoid weird program behaviors
  { event = { Up = { streak = 1, button = "Left" } },              mods = "NONE", action = act.CompleteSelection "ClipboardAndPrimarySelection" },
  { event = { Up = { streak = 1, button = "Left" } },              mods = "CTRL", action = act.OpenLinkAtMouseCursor },
  { event = { Down = { streak = 1, button = "Left" } },            mods = "CTRL", action = act.Nop },
  -- Wheel
  -- Scrolling up/down while holding CTRL increases/decreases the font size
  { event = { Down = { streak = 1, button = { WheelUp = 1 } } },   mods = "CTRL", action = act.IncreaseFontSize },
  { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = "CTRL", action = act.DecreaseFontSize }
}

--------------------------------------------------------------------------------
--               ------- WSL Domains ------
--------------------------------------------------------------------------------
config.wsl_domains = {
  {
    name = "WSL:Ubuntu",
    distribution = ubuntu_distribution,
    username = "ubuntu",
    default_cwd = "/home/ubuntu",
    default_prog = { "zsh" }
  },
  {
    name = "WSL:Kali-Linux",
    distribution = "kali-linux",
    username = "kali",
    default_cwd = "/home/kali",
    default_prog = { "bash" }
  },
}

local domain_keys = {
  {
    key = "w",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      local tab = win:mux_window():spawn_tab({ cwd = "C:\\code-win", domain = "DefaultDomain" })
      tab:set_title("PowerShell")
    end)
  },
  {
    key = "k",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      local tab = win:mux_window():spawn_tab({ domain = { DomainName = "WSL:Kali-Linux" } })
      tab:set_title("Kali")
    end)
  },
  {
    key = "u",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      local tab = win:mux_window():spawn_tab({ cwd = "/home/ubuntu", domain = { DomainName = "WSL:Ubuntu" } })
      tab:set_title("Ubuntu")
    end)
  }
}

for _, keymap in ipairs(domain_keys) do
  table.insert(config.keys, keymap)
end

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
config.color_scheme = default_theme

-- Font
config.font = wezterm.font("MesloLGM Nerd Font")
config.font_size = 11

-- Cursor
config.default_cursor_style = "SteadyBlock"

--------------------------------------------------------------------------------
--               ------- Plugin - Resurrect ------
--------------------------------------------------------------------------------
---https://mwop.net/blog/2024-10-21-wezterm-resurrect.html
-- local resurrect = require "resurrect/config"

-- for _, keymap in ipairs(resurrect.keys) do
--   table.insert(config.keys, keymap)
-- end

--------------------------------------------------------------------------------
--               ------- Plugin - Sessions ------
--------------------------------------------------------------------------------
-- local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
-- sessions.apply_to_config(config)

local sessions_keys = {
  -- { key = "s", mods = "LEADER|CTRL", action = act({ EmitEvent = "save_session" }) },
  -- { key = "l", mods = "LEADER|CTRL", action = act({ EmitEvent = "load_session" }) },
  -- { key = "r", mods = "LEADER|CTRL", action = act({ EmitEvent = "restore_session" }) },
  -- { key = "d", mods = "LEADER|CTRL", action = act({ EmitEvent = "delete_session" }) },
  -- { key = "e", mods = "LEADER|CTRL", action = act({ EmitEvent = "edit_session" }) },
  -- Rename current workspace
  {
    key = "e",
    mods = "CTRL",
    action = act.PromptInputLine {
      description = "Enter new workspace name",
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end) }
  },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = "n",
    mods = "CTRL",
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(act.SwitchToWorkspace { name = line, }, pane)
        end
      end) }
  }
}

for _, keymap in ipairs(sessions_keys) do
  table.insert(config.keys, keymap)
end

--------------------------------------------------------------------------------
--               ------- Plugin - Smart Workspace Switcher ------
--------------------------------------------------------------------------------
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- Keybindings
local switcher_keys = {
  { key = "w", mods = "LEADER|CTRL", action = workspace_switcher.switch_workspace() },
}

for _, keymap in ipairs(switcher_keys) do
  table.insert(config.keys, keymap)
end

--------------------------------------------------------------------------------
--               ------- Plugin - Command Sender ------
--------------------------------------------------------------------------------
local cmd_sender = wezterm.plugin.require("https://github.com/aureolebigben/wezterm-cmd-sender")

local cmd_sender_key = {
  key = ":",
  mods = "CTRL|SHIFT",
  description = "Enter command to send to all panes of active tab"
}

cmd_sender.apply_to_config(config, cmd_sender_key)

--------------------------------------------------------------------------------
--               ------- Plugin - Tabline ------
--------------------------------------------------------------------------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
  options = {
    icons_enabled = true,
    theme = tabline_theme,
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { "mode" },
    tabline_b = { "workspace" },
    tabline_c = { " " },
    tab_active = {
      "index",
      { "tab",    padding = { left = 0, right = 1 } },
      { "zoomed", padding = 0 },
    },
    tab_inactive = { "index", { "tab", padding = { left = 0, right = 1 } } },
    tabline_x = {},
    tabline_y = { "cpu", "ram" },
    tabline_z = { "domain" },
  },
  extensions = { "resurrect" },
})

tabline.apply_to_config(config)

--------------------------------------------------------------------------------
--               ------- Startup ------
--------------------------------------------------------------------------------
config.default_prog = { "pwsh.exe", "-NoLogo" }

wezterm.on("gui-startup", function()
  -- First tab: PowerShell in code-win directory
  local tab1, _, window = mux.spawn_window {
    cwd = "C:\\code-win",
    domain = "DefaultDomain",
    workspace = "work"
  }
  window:gui_window():maximize()
  tab1:set_title("PowerShell")

  -- Second tab: WSL Ubuntu with dashboard
  local tab2, pane21, _ = window:spawn_tab {
    args = { "zsh", "-c", "fastfetch; exec zsh" },
    cwd = "/home/ubuntu",
    domain = { DomainName = "WSL:Ubuntu" },
  }
  local pane22 = pane21:split {
    args = { "zsh", "-c", "lazydocker; exec zsh" },
    cwd = "/home/ubuntu",
    domain = { DomainName = "WSL:Ubuntu" },
    direction = "Bottom",
    size = 0.5
  }
  local _ = pane21:split {
    args = { "zsh", "-c", "btop" },
    cwd = "/home/ubuntu",
    domain = { DomainName = "WSL:Ubuntu" },
    direction = "Right",
    size = 0.75
  }
  local pane23 = pane22:split {
    args = { "zsh", "-c", "tokei /home/ubuntu/code -t Dockerfile,HCL,Python,Shell,SQL,TOML,YAML,Markdown; exec zsh" },
    cwd = "/home/ubuntu",
    domain = { DomainName = "WSL:Ubuntu" },
    direction = "Right",
    size = 0.25
  }
  tab2:set_title("Dashboard")

  -- Third tab: WSL Ubuntu in /home/ubuntu directory
  local tab3, _, _ = window:spawn_tab { cwd = "/home/ubuntu", domain = { DomainName = "WSL:Ubuntu" } }
  tab3:set_title("Ubuntu")

  pane23:activate()

  mux.set_active_workspace "work"
end)

return config
