-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()


math.randomseed(os.time() + math.floor(os.clock() * 1e6))

local function random_file(dir, pattern)
  pattern = pattern or "*"
  local files = wezterm.glob(dir .. "/" .. pattern)
  if not files or #files == 0 then
    return nil, "no files in " .. dir
  end
  return files[math.random(#files)]
end

local backgrounds = wezterm.home_dir .. "\\Pictures\\Terminal Background"
local bg, err = random_file(backgrounds, "*.jpg") or random_file(backgrounds, "*.png")

if err then
  wezterm.log_error(err)
else
  wezterm.log_info("Using background image: " .. bg)
end

config.font = wezterm.font_with_fallback {
  -- {
  --   family = 'JetBrainsMono Nerd Font',
  --   weight = 'Medium',
  -- },
  {
    family = 'Nordwand Mono',
    weight = 'Regular',
  },
  -- {
  --   family = 'Symbols Nerd Font',
  --   -- weight = 'Small',
  -- },

}
config.font_size = 13
config.line_height = 1.05

config.enable_tab_bar = false

config.background = {
  {
    source = {
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\1127004.jpg"
        File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\375_Anime_Wallpaper_3840x2160px.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\black-and-white-zoro-swordfighter-anime-wallpaper-preview.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\demon-slayer-3840x2160-17629.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\demon-slayer-3840x2160-9326.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\full-shot-ninja-wearing-equipment.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\full-shot-ninjas-fighting.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\giyu-tomioka-3840x2160-23653.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\kyojuro-rengoku-5k-3840x2160-13969.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\marvel-iron-man-in-destroyed-suit-desktop-wallpaper-preview.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\miyamoto-musashi-5k-3840x2160-15210.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\movie-wallpapers-iron-man.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\muichiro-tokito-3840x2160-23644.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\mythical-dragon-beast-anime-style.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\wp2609060-himalaya-wallpaper.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\wp7378275-ps4-anime-scenery-wallpapers.jpg"
        -- File="C:\\Users\\ark8kor\\Pictures\\Terminal Background\\zenitsu-agatsuma-3840x2160-23643.jpg"
        -- File = bg,
    },
    hsb = {
        hue =1.0,          -- 1.0 = unchanged
        saturation = 1,   -- <1 desaturates
        brightness = 0.01,  -- Lower to keep text readable
      },
  },
}

config.color_scheme = "Catppuccin Mocha"

config.default_gui_startup_args = { 'ssh', 'rt-z0n1p' }
-- config.color_scheme = "Solarized Osaka"

-- and finally, return the configuration to wezterm
return config