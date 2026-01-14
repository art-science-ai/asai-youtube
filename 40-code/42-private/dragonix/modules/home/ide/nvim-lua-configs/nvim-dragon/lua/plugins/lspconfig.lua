-- =====================================================================
-- LSPCONFIG: LSP client manager for Neovim
-- =====================================================================
--
-- Minimal LSP setup that connects to Nix-installed language servers.
-- Uses nvim-lspconfig to manage connections without any additional complexity.
--
-- LSP servers are expected to be installed via Nix, not Mason.
-- Customization for each server goes in after/lsp/<server>.lua
--
-- =====================================================================

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
  dependencies = {
    -- Optional: For better LSP UI
    { "folke/trouble.nvim", opts = {} },
  },
  config = function()
    -- Global keybindings for LSP
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

    -- Default capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Define LSP server configurations (using modern vim.lsp.config API)
    -- This replaces the deprecated require('lspconfig') approach

    -- Configure language servers (installed via Nix)
    -- Uncomment servers you have installed

    -- Lua language server (example)
    local util = require('lspconfig.util')
    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_dir = util.root_pattern('.luarc.json', '.git'),
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
        },
      },
    })

    -- Configure markdown when you install marksman via Nix
    -- vim.lsp.config('marksman', {
    --   cmd = { 'marksman' },
    --   filetypes = { 'markdown' },
    --   root_dir = util.root_pattern('.marksman.toml', '.git'),
    --   capabilities = capabilities,
    -- })

    -- Configure Nix when you install nil or nixd via Nix
    -- vim.lsp.config('nil', {
    --   cmd = { 'nil' },
    --   filetypes = { 'nix' },
    --   root_dir = util.root_pattern('flake.nix', '.git'),
    --   capabilities = capabilities,
    -- })

    -- Configure Python when you install pyright via Nix
    -- vim.lsp.config('pyright', {
    --   cmd = { 'pyright-langserver', '--stdio' },
    --   filetypes = { 'python' },
    --   root_dir = util.root_pattern('pyproject.toml', 'setup.py', '.git'),
    --   capabilities = capabilities,
    -- })

    -- Configure TypeScript/JavaScript when you install typescript-language-server via Nix
    -- vim.lsp.config('ts_ls', {
    --   cmd = { 'typescript-language-server', '--stdio' },
    --   filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    --   root_dir = util.root_pattern('tsconfig.json', 'package.json', '.git'),
    --   capabilities = capabilities,
    -- })

    -- Set up autocmds to start LSP servers when opening matching filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua' },
      callback = function()
        vim.lsp.enable('lua_ls')
      end,
      desc = 'Start Lua language server for Lua files',
    })

    -- Uncomment these autocmds when you install the corresponding servers
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = { 'markdown' },
    --   callback = function()
    --     vim.lsp.enable('marksman')
    --   end,
    --   desc = 'Start marksman for Markdown files',
    -- })

    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = { 'nix' },
    --   callback = function()
    --     vim.lsp.enable('nil')
    --   end,
    --   desc = 'Start nil for Nix files',
    -- })

    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = { 'python' },
    --   callback = function()
    --     vim.lsp.enable('pyright')
    --   end,
    --   desc = 'Start pyright for Python files',
    -- })
  end,
}