return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- You can add language-specific adapters here
    end,
  },

{
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local dap_status, dap = pcall(require, "dap")
    local dapui_status, dapui = pcall(require, "dapui")
    if not (dap_status and dapui_status) then return end

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
},
  -- Optional: Virtual text (inline variable display)
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- Optional: Telescope integration
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}

