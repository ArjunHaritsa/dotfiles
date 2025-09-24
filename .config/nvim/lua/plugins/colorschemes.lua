return {
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        styles = {
          floats = "transparent",
        },
        day_brightness = 0.7,
        lualine_bold = false,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
      })
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },
  { "rose-pine/neovim", name = "rose-pine" },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  { "EdenEast/nightfox.nvim", name = "nightfox" },
  { "aliqyan-21/darkvoid.nvim", name = "darkvoid" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
