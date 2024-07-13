local plugins = {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
        },
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "<Tab>",
      act_as_tab = true,
      behavior = "nested", ---@type ntab.behavior
      pairs = { ---@type ntab.pair[]
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "<", close = ">" },
      },
      exclude = {},
      smart_punctuators = {
        enabled = false,
        semicolon = {
            enabled = false,
            ft = { "cs", "c", "cpp", "java" },
        },
        escape = {
            enabled = false,
            triggers = {}, ---@type table<string, ntab.trigger>
        },
      },
    }
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"folke/which-key.nvim" -- Добавляем which-key.nvim
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")
			local which_key = require("which-key")

      -- Функция для поиска виртуального окружения в текущем каталоге проекта
      local function detect_venv()
        local cwd = vim.fn.getcwd()
        local python_path = vim.fn.system("pyenv which python")
        if python_path:find("pyenv") then
          return { python = python_path:gsub("%s+", "") }
        else
          return { python = "python" }
        end
      end

			-- Setup dap-python with the detected virtual environment
			dap_python.setup(detect_venv().python)

			-- Setup dap-ui
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
      
			-- Key mappings for debugging
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last" })
			vim.keymap.set("n", "<Leader>ds", dap.terminate, { desc = "Stop Debugging" })

			-- Additional key mappings for dap-ui
			vim.keymap.set("n", "<Leader>de", dapui.eval, { desc = "Evaluate" })
			vim.keymap.set("v", "<Leader>de", dapui.eval, { desc = "Evaluate" })

			-- Key mapping to run the current file
			vim.keymap.set("n", "<Leader>df", function()
				local file = vim.fn.expand("%")
				vim.cmd("!python " .. file)
			end, { desc = "Run Current File" })

		end,
	},

  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "mypy",
        "ruff-lsp",
        "pyright",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup{
        before_init = function(_, config)
          config.settings.python.pythonPath = '/home/user/.pyenv/shims/python'
        end
      }
    end,
  },
}
return plugins

