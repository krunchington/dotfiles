local wezterm = require 'wezterm'

local config = wezterm.config_builder()

if wezterm.target_triple:find("windows") then
    -- run `wsl -l -v` in terminal, output will look like:
    --   NAME       STATE       VERSION
    -- * Ubuntu     Running     2
    --
    -- prepend "WLS:" to the NAME
    config.default_domain = 'WSL:Ubuntu'
end


-- cyberdream theme for wezterm
config.colors = {
    foreground = "#ffffff",
    background = "#16181a",

    cursor_bg = "#ffffff",
    cursor_fg = "#16181a",
    cursor_border = "#ffffff",

    selection_fg = "#ffffff",
    selection_bg = "#3c4048",

    scrollbar_thumb = "#16181a",
    split = "#16181a",

    ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
}

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.background = {
    {
        source = { File= wezterm.home_dir .. '/.wezterm/samurai.png' },
        hsb = {
            brightness = 0.1,
            hue = 1.0,
            saturation = 1.0,
        }
    },
    {
        source = { Color='black' },
        opacity = 0.6,
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
