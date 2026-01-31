-- my remaps
vim.g.mapleader = " "
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
-- indents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- for filtering quickfix window
vim.cmd("packadd cfilter")
-- infra
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300
-- use the system clipboard
vim.opt.clipboard = 'unnamedplus'

------------------------------------------------------------------

-- enter in normal mode to insert a new line after the current line
-- apart from in quickfix where it should go to the file/error
vim.keymap.set("n", "<CR>", "o<Esc>")
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    -- The { buffer = true } option makes this mapping local to the current buffer,
    -- which is equivalent to <buffer> in Vimscript.
    vim.keymap.set('n', '<CR>', '<CR>', { noremap = true, silent = true, buffer = true })
  end,
  desc = 'Jump to entry in quickfix window on <CR>'
})
-- select line(s) and move them around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- close the current buffer
vim.keymap.set("n", ":bd", ":bp <BAR> bd #<CR>")
-- move between buffers
vim.keymap.set("n", "<S-H>", ":bp<CR>")
vim.keymap.set("n", "<S-L>", ":bn<CR>")
-- replace word under cursor
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- "search up/down" to stay in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- paste without copying the yanked value
vim.keymap.set("n", "<leader>p", "\"+y")
-- move next/previous item in quickfix window
vim.keymap.set("n", "qn", ":cn<CR>")
vim.keymap.set("n", "qp", ":cp<CR>")

--------------- START PLUGIN CONFIG ------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
------------------------------------------------------

require("lazy").setup({
  {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.cmd.colorscheme "vscode"
    end
  },
  {
    'christoomey/vim-tmux-navigator'
  },
  {
	  'ap/vim-buftabline',
	  config = function()
		  vim.g.buftabline_indicators = 1
	  end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
      vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
      vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>")
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {},
    config = function()
      require("mason").setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("rust_analyzer")

      -- check out https://neovim.io/doc/user/lsp.html#_global-defaults
      -- for other key bindings, etc.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- enable/disable inlay hints
          vim.keymap.set("n", "<leader>ch", function()
            local enabled = not vim.lsp.inlay_hint.is_enabled({})
            vim.lsp.inlay_hint.enable(enabled)
          end)
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
        end,
      })
    end
  }
})

--------------- END OF PLUGIN CONFIG ------------------

-- set default grep program as ripgrep (ensure it is installed)
require('grep-settings')

-- Press 'x' in the quickfix window to remove the line under the cursor
local function qf_remove_at_cursor()
  local curr_line = vim.fn.line('.')
  local all_items = vim.fn.getqflist()

  -- If the list is empty or the line number is invalid, do nothing.
  if #all_items == 0 or curr_line > #all_items then
    return
  end

  -- Build a new list, excluding the item at the current line.
  local filtered_items = {}
  for i, item in ipairs(all_items) do
    if i ~= curr_line then
      table.insert(filtered_items, item)
    end
  end

  -- Replace the quickfix list with our newly filtered list.
  vim.fn.setqflist(filtered_items, 'r')

  -- After removing an item, the list is shorter. The cursor moves automatically,
  -- but we want to place it back on the same line number if possible.
  -- If we removed the last item, this will correctly place it on the new last item.
  local new_total_lines = #filtered_items
  if #filtered_items > 0 then
    local new_cursor_line = math.min(curr_line, new_total_lines)
    vim.api.nvim_win_set_cursor(0, { new_cursor_line, 0 })
  end
end

local qf_augroup = vim.api.nvim_create_augroup('MyQfKeymaps', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qf_augroup,
  desc = 'Map x to remove the current item from the quickfix list',
  callback = function()
    -- Creates a silent mapping for 'x' that is local to the quickfix buffer.
    vim.keymap.set('n', 'x', qf_remove_at_cursor, { silent = true, buffer = true })
  end,
})
