-- mappings.lua
local M = {}

M.dap = {
  n = {
    ["<Leader>dt"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ["<Leader>dc"] = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
    ["<Leader>do"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
    ["<Leader>di"] = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
    ["<Leader>du"] = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
    ["<Leader>dr"] = { "<cmd>lua require('dap').repl.open()<CR>", "Open REPL" },
    ["<Leader>dl"] = { "<cmd>lua require('dap').run_last()<CR>", "Run Last" },
    ["<Leader>ds"] = { "<cmd>lua require('dap').terminate()<CR>", "Stop Debugging" },
    ["<Leader>de"] = { "<cmd>lua require('dapui').eval()<CR>", "Evaluate" },
    ["<Leader>df"] = {
      "<cmd>lua local file = vim.fn.expand('%') vim.cmd('python ' .. file)<CR>",
      "Run Current File"
    },
  },
  v = {
    ["<Leader>de"] = { "<cmd>lua require('dapui').eval()<CR>", "Evaluate" },
  },
}

return M
