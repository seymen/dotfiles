local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "target"
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

require("telescope").load_extension("ui-select")

-- configure key bindings
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>s', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
