return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
      -- your other adapters here
    },
    opts = {
      adapters = {
        ["neotest-gtest"] = {},
      },
    },
    keys = {
      {
        "<leader>tC",
        ":ConfigureGtest",
        desc = "Test Binary",
      },
    },
  },
}
