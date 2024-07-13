-- lua/custom/configs/null-ls.lua
local null_ls = require("null-ls")
local Path = require("plenary.path")

local opts = {
  sources = {
    null_ls.builtins.formatting.black.with({
      command = function()
        -- Use pyenv to get the correct Python executable
        local python_executable = io.popen("pyenv which python"):read()
        return python_executable:trim() .. " -m black"
      end,
    }),
    null_ls.builtins.diagnostics.mypy.with({
      command = "mypy",
      extra_args = function()
        -- Use pyenv to get the correct Python executable
        local python_executable = io.popen("pyenv which python"):read()
        return { "--python-executable", python_executable:trim() }
      end,
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return opts

