-- The whole thing is coming from:
-- https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3

-- Set grepprg to use ripgrep with specific flags
vim.o.grepprg = 'rg --vimgrep --smart-case'

---
-- Define the Grep function
-- This function is placed in the global scope (_G) so it can be called
-- from the string-based command definitions below using `v:lua.`.
_G.Grep = function(...)
  -- Join all function arguments into a single string
  local user_args = table.concat({ ... }, ' ')
  -- Expand Vim command-line special characters (like `%` for current file)
  local expanded_args = vim.fn.expandcmd(user_args)
  -- Construct the full shell command
  local cmd = vim.o.grepprg .. ' ' .. expanded_args
  -- Execute the command and return its output
  return vim.fn.system(cmd)
end

---
-- Create user commands :Grep and :LGrep
vim.api.nvim_create_user_command(
  'Grep',
  'cgetexpr v:lua.Grep(<f-args>)', -- Populates the quickfix list
  {
    nargs = '+', -- Requires one or more arguments
    complete = 'file_in_path', -- Provides file path completion
    bar = true, -- Allows chaining with `|`
  }
)

vim.api.nvim_create_user_command(
  'LGrep',
  'lgetexpr v:lua.Grep(<f-args>)', -- Populates the location list
  {
    nargs = '+',
    complete = 'file_in_path',
    bar = true,
  }
)

---
-- Create command-line abbreviations to capitalize grep/lgrep
-- This makes the custom commands feel like built-in ones.
vim.cmd([[cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep']])
vim.cmd([[cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep']])

---
-- Create autocommands to automatically open the quickfix/location window
local qf_group = vim.api.nvim_create_augroup('MyQuickfix', { clear = true })

-- After populating the quickfix list with cgetexpr, open the quickfix window
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'cgetexpr',
  command = 'cwindow',
  group = qf_group,
})

-- After populating the location list with lgetexpr, open the location list window
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lgetexpr',
  command = 'lwindow',
  group = qf_group,
})
