local wezterm = require 'wezterm'
local act = wezterm.action

mb = {
}

for i = 1,99,1 
do 
  table.insert(mb,
  {
    event = { Down = { streak = i, button = 'Middle' } },
    mods = 'NONE',
    action = act.PasteFrom("PrimarySelection")
  })
  table.insert(mb, {
    event = { Down = { streak = i, button = 'Right' } },
       mods = 'NONE',
       action = wezterm.action_callback(function(window, pane)
         local has_selection = window:get_selection_text_for_pane(pane) ~= ''
         if has_selection then
           window:perform_action(
             act.CopyTo 'ClipboardAndPrimarySelection',
             pane
           )
   
           window:perform_action(act.ClearSelection, pane)
         else
           window:perform_action(act.PasteFrom("PrimarySelection"), pane)
         end
       end),
     })
end

return {
  disable_default_key_bindings = true,
  pane_focus_follows_mouse = false,
  mouse_bindings = mb,
--  leader = { key = 'VoidSymbol', timeout_milliseconds = 1000 },
  keys = {
--    {
--      key = 'c',
--      mods = 'CTRL|SHIFT',
--      action = wezterm.action.SpawnCommandInNewTab {
--        args = { 'zsh' },
--        cwd = '~'
--      },
--    },
    {
      key = 'PageUp',
      mods = 'SHIFT',
      action = act.ScrollByPage(-1),
    },
    {
      key = 'x',
      mods = 'CTRL',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = 'PageDown',
      mods = 'SHIFT',
      action = act.ScrollByPage(1),
    },
    {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = act.PasteFrom("Clipboard"),
    },
    {
      key = 'c',
      mods = 'CTRL|SHIFT',
      action = act.CopyTo("Clipboard"),
    },
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SpawnCommandInNewTab {
        args = { 'zsh' },
        cwd = '~'
      },
    },
    {
      key = 'f',
      mods = 'CTRL',
      action = wezterm.action.TogglePaneZoomState,
    },
--    {
--      key = 'p',
--      mods = 'LEADER',
--      action = act.ActivateTabRelative(-1),
--    },
--    {
--      key = 'n',
--      mods = 'LEADER',
--      action = act.ActivateTabRelative(1),
--    },
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
    {
      key = '2',
      mods = 'CTRL',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '2',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '5',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '5',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'LeftArrow',
      mods = 'CTRL',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'CTRL',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'CTRL',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'CTRL',
      action = act.ActivatePaneDirection 'Down',
    }
  },
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  window_frame = {
    border_left_width = '0.5cell',
    border_right_width = '0.5cell',
  },
  window_background_opacity = 0.97,
  window_decorations = "NONE",
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  scrollback_lines = 999999,
  enable_scroll_bar = false,
  adjust_window_size_when_changing_font_size=false,
  font =  wezterm.font_with_fallback({"Hack", "Twemoji"}),
  font_size = 15,
  force_reverse_video_cursor = false,
  colors = {
    ansi = {
        '#1d1f21',
        '#cc6666',
        '#b5bd68',
        '#f0c674',
        '#81a2be',
        '#b294bb',
        '#8abeb7',
        '#c5c8c6'
    },
    background = '#1d1f21',
    brights = {
        '#969896',
        '#cc6666',
        '#b5bd68',
        '#f0c674',
        '#81a2be',
        '#b294bb',
        '#8abeb7',
        '#ffffff'
    },
    foreground = '#c5c8c6',
    selection_bg = '#373b41',
    selection_fg = '#c5c8c6',
    cursor_bg = '#c5c8c6',
    cursor_border = '#c5c8c6',
    cursor_fg = '#1d1f21',
  },
--    color_scheme = 'Catppuccin Macchiato',
--  default_cursor_style = 'BlinkingBlock',
--  cursor_blink_rate = 500,
--  animation_fps = 100,
--  front_end = "Software",
}
