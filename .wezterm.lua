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

local backgrounds = wezterm.home_dir .. "/Personal/Wallpapers"
local bg, err = random_file(backgrounds, "*.jpg")
	or random_file(backgrounds, "*.jpeg")
	or random_file(backgrounds, "*.png")

if err then
	wezterm.log_error(err)
else
	wezterm.log_info("Using background image: " .. bg)
end

config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Medium",
	},
	-- {
	-- 	family = "FiraCode Nerd Font",
	-- 	weight = "Regular",
	-- },
})
config.font_size = 16
config.line_height = 1.05

config.enable_tab_bar = false

config.background = {
	{
		source = {
			File = bg,
		},
		hsb = {
			hue = 1.0, -- 1.0 = unchanged
			saturation = 1, -- <1 desaturates
			brightness = 0.01, -- Lower to keep text readable
		},
	},
}

config.color_scheme = "Catppuccin Mocha"

-- and finally, return the configuration to wezterm
return config
