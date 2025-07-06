-- this config from
-- https://www.youtube.com/watch?v=zHTeCSVAFNY

-- install lazy if it doesn't exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",

    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- define lazy options
local opts = {}

-- define and list the plugins you want
local plugins = {
  { -- color theme
    'Mofiqul/vscode.nvim',
    name = "vscode",
    priority = 1000
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { -- sets default nvim selector ui to telescope
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  { -- all lsp plugins
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    "numToStr/Comment.nvim"
  },
  {
    'christoomey/vim-tmux-navigator'
  },
	{
    'ap/vim-buftabline'
  },
  { -- code completions
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      floating_window = false,
      handler_opts = {
        border = "rounded"
      }
    },
  },
  { -- code snippets
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
  },
  { -- git plugins
    'lewis6991/gitsigns.nvim',
    'tpope/vim-fugitive',
  },
}

-- load lazy
-- plugin configurations are in after/plugin folder
require("lazy").setup(plugins, opts)
