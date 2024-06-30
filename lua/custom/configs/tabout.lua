local tabout = require("tabout")

tabout.setup({
  tabkey = '<Tab>', -- key to trigger tabout
  backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout
  act_as_tab = true, -- shift content if possible
  act_as_shift_tab = false, -- shift content in reverse if possible
  enable_on_vim_enter = true, -- enable tabout on vim enter
  exclude = { -- exclude these filetypes/buftypes from tabout
    "TelescopePrompt",
    "Trouble",
    "null-ls-info",
    "dap-repl",
  },
  -- ... other options ...
})
