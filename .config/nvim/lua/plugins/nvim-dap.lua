return {
  "mfussenegger/nvim-dap",

  -- stylua: ignore
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<F6>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<F7>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F8>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<F9>", function() require("dap").pause() end, desc = "Pause" },
    { "<F4>", function() require("dap").terminate() end, desc = "Terminate" },
  },
}
