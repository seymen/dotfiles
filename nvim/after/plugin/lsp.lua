-- :LspInfo in any buffer will show you what lsp servers are connected to that buffer

-- setup language servers
require("mason").setup()
require("mason-lspconfig").setup({
  -- list of all lsp servers:
  -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
  ensure_installed = {
    "lua_ls",
    "rust_analyzer"
  }
})

-- setup language clients
-- to add support for another language, add the language under `ensure_installed`
-- and do lspconfig.xyz.setup({})
local lspconfig = require("lspconfig")

-- lsp keybinding configuration
-- https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- setting for lua
lspconfig.lua_ls.setup({capabilities = capabilities})
lspconfig.rust_analyzer.setup({capabilities = capabilities})
