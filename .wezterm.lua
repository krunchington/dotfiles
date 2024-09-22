local wezterm = require 'wezterm'

local config = wezterm.config_builder()

if wezterm.target_triple:find("windows") then
    -- run `wsl -l -v` in terminal, output will look like:
    --
    --   NAME      STATE           VERSION
    -- * Ubuntu    Running         2
    --
    -- prepend "WSL:" to the NAME
    config.default_domain = 'WSL:Ubuntu'
end

config.color_scheme = 'cyberpunk'

config.background = {
    {
        source = { File= wezterm.home_dir .. '/.wezterm/cyberpunk.jpg' },
        hsb = {
            brightness = 0.1,
            hue = 1.0,
            saturation = 1.0,
        }
    },
    {
        source = { Color='black' },
        opacity = 0.4,
        width = "100%",
        height = "100%",
    },
}

config.inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.5,
    hue = 1.0,
}

return config
