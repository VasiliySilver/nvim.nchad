-- lua/custom/configs/null-ls.lua
local null_ls = require("null-ls")
local Path = require("plenary.path")

local opts = {
  sources = {
    null_ls.builtins.formatting.black.with({
      command = function()
        local root_dir = vim.fn.getcwd()
        local black_path = Path:new(root_dir, ".venv", "bin", "black")
        if black_path:exists() then
          return black_path:absolute()
        else
          -- Если .venv не существует, используем системный black
          return "black"
        end
      end,
    }),
    null_ls.builtins.diagnostics.mypy.with({
      command = function()
        local root_dir = vim.fn.getcwd()
        local mypy_path = Path:new(root_dir, ".venv", "bin", "mypy")
        if mypy_path:exists() then
          return mypy_path:absolute()
        else
          -- Если .venv не существует, используем системный mypy
          return "mypy"
        end
      end,
      extra_args = function()
        local root_dir = vim.fn.getcwd()
        local python_path = Path:new(root_dir, ".venv", "bin", "python")
        if python_path:exists() then
          return { "--python-executable", python_path:absolute() }
        else
          -- Если .venv не существует, используем системный Python
          return { "--python-executable", "/usr/bin/python3" }
        end
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

