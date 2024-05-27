local config =
  {
    controls = {
        element = "repl",
        enabled = true
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.4
          },
          {
            id = "watches",
            size = 0.4
          },
          {
            id = "breakpoints",
            size = 0.2
          }
        } ,
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "stacks",
            size = 0.5
          }, {
            id = "repl",
            size = 0.5
          } },
        position = "bottom",
        size = 15
      } }
  }


require('dapui').setup(config)

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()
