return {
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
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
          floats = "transparent", -- style for floating windows
        },
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "carbonfox",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
        groups = {
          all = {
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            FloatTitle = { bg = "NONE" },
            -- SnacksExplorerNormal = { bg = "NONE" },
            -- SnacksExplorerBorder = { bg = "NONE" },
          },
        },
      })
    end,
  },
  { "diegoulloao/neofusion.nvim", priority = 1000, config = true, opts = ... },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "Aejkatappaja/sora",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      on_colors = function(colors)
        colors.string = colors.rose
      end,
    },
    config = function(_, opts)
      require("sora").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sora",
    },
  },
}
