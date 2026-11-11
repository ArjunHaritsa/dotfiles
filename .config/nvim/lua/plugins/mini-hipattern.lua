-- Helper function to convert RGB integers to a hex string
local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Helper function to convert HSL to RGB, then to Hex
local function hsl_to_hex(h, s, l)
  s, l = s / 100, l / 100
  local c = (1 - math.abs(2 * l - 1)) * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = l - c / 2
  local r, g, b = 0, 0, 0

  if h < 60 then
    r, g, b = c, x, 0
  elseif h < 120 then
    r, g, b = x, c, 0
  elseif h < 180 then
    r, g, b = 0, c, x
  elseif h < 240 then
    r, g, b = 0, x, c
  elseif h < 300 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end

  return rgb_to_hex(math.floor((r + m) * 255 + 0.5), math.floor((g + m) * 255 + 0.5), math.floor((b + m) * 255 + 0.5))
end

return {
  {
    "nvim-mini/mini.hipatterns",
    opts = function(_, opts)
      local hi = require("mini.hipatterns")

      -- Ensure highlighters subtable exists without wiping any defaults
      opts.highlighters = opts.highlighters or {}

      -- 1. Keeps your normal #ffffff CSS hex highlighting active
      opts.highlighters.hex_color = hi.gen_highlighter.hex_color()

      -- 2. C++ style hex: 0xRRGGBB (Matches lines like alice_blue = 0xF0F8FF)
      opts.highlighters.cpp_hex = {
        pattern = "0x%x%x%x%x%x%x%f[%X]",
        group = function(_, match)
          local hex = "#" .. match:sub(3)
          return hi.compute_hex_color_group(hex, "bg")
        end,
      }

      -- 3. RGB highlighter: matches rgb(255, 255, 255) or rgb(255 255 255)
      opts.highlighters.rgb_color = {
        pattern = "rgb%(%d+,? %d+,? %d+%)",
        group = function(_, match)
          local r, g, b = match:match("rgb%((%d+),? (%d+),? (%d+)%)")
          r, g, b = tonumber(r), tonumber(g), tonumber(b)
          if r and g and b and r <= 255 and g <= 255 and b <= 255 then
            return hi.compute_hex_color_group(rgb_to_hex(r, g, b), "bg")
          end
        end,
      }

      -- 4. HSL highlighter: matches hsl(360, 100%, 100%) or hsl(360 100% 100%)
      opts.highlighters.hsl_color = {
        pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
        group = function(_, match)
          local h, s, l = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
          h, s, l = tonumber(h), tonumber(s), tonumber(l)
          if h and s and l and h <= 360 and s <= 100 and l <= 100 then
            return hi.compute_hex_color_group(hsl_to_hex(h, s, l), "bg")
          end
        end,
      }
    end,
  },
}
