-- File: resurrect/config.lua
-- resurrect.wezterm configuration and settings
--
-- This module:
-- * Configures the resurrect.wezterm plugin
-- * Configures event listener configuration (via an additional required file)
-- * Returns wezterm keybinding configuration for resurrect-related actions.
--
-- The main wezterm configuration is then responsible for merging the
-- keybindings with other keybindings, or setting up its own.

local config    = {}
local wezterm   = require "wezterm"
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- resurrect.wezterm encryption
-- Uncomment the following to use encryption.
-- If you do, ensure you have the age tool installed, you have created an
-- encryption key at ~/.config/age/wezterm-resurrect.txt, and that you supply
-- the associated public_key below
resurrect.state_manager.set_encryption({
    enable      = true,
    method      = "age",
    private_key = wezterm.home_dir .. "/.config/age/key.txt",
    public_key  = "<public-key-value>",
})

-- resurrect.wezterm periodic save every 5 minutes
resurrect.state_manager.periodic_save({ interval_seconds = 300, save_tabs = true, save_windows = true, save_workspaces = true })

-- Save only 5000 lines per pane
resurrect.state_manager.set_max_nlines(5000)

-- Default keybindings
-- These will need to be merged with the main wezterm keys.
config.keys = {
    {
        -- Save current and window state
        key = "s",
        mods = "LEADER|CTRL",
        action = wezterm.action_callback(function(win, pane) -- luacheck: ignore 212
            local state = resurrect.workspace_state.get_workspace_state()
            resurrect.state_manager.save_state(state)
            resurrect.window_state.save_window_action()
        end),
    },
    {
        -- Load workspace or window state, using a fuzzy finder
        key = "l",
        mods = "LEADER|CTRL",
        action = wezterm.action_callback(function(win, pane)
            resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label) -- luacheck: ignore 212
                local type = string.match(id, "^([^/]+)")                    -- match before "/"
                id         = string.match(id, "([^/]+)$")                    -- match after "/"
                id         = string.match(id, "(.+)%..+$")                   -- remove file extension

                local opts = {
                    window          = win:mux_window(),
                    relative        = true,
                    restore_text    = true,
                    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
                }

                if type == "workspace" then
                    local state = resurrect.state_manager.load_state(id, "workspace")
                    resurrect.workspace_state.restore_workspace(state, opts)
                elseif type == "window" then
                    local state = resurrect.state_manager.load_state(id, "window")
                    -- opts.tab = win:active_tab()
                    resurrect.window_state.restore_window(pane:window(), state, opts)
                elseif type == "tab" then
                    local state = resurrect.state_manager.load_state(id, "tab")
                    resurrect.tab_state.restore_tab(pane:tab(), state, opts)
                end
            end)
        end),
    },
    {
        -- Delete a saved session using a fuzzy finder
        key = "d",
        mods = "LEADER|CTRL",
        action = wezterm.action_callback(function(win, pane)
            resurrect.fuzzy_loader.fuzzy_load(
                win,
                pane,
                function(id)
                    resurrect.state_manager.delete_state(id)
                end,
                {
                    title             = "Delete State",
                    description       = "Select session to delete and press Enter = accept, Esc = cancel, / = filter",
                    fuzzy_description = "Search session to delete: ",
                    is_fuzzy          = true,
                }
            )
        end),
    }
}

require "resurrect/events"

return config
