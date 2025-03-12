return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        styles = {
          floats = "transparent",
        },
        day_brightness = 0.7,
        lualine_bold = true,
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
