local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local servers = { "yamlls", "dockerls", "jsonls", "elixirls" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         -- root_dir = vim.loop.cwd,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   if not lspconfig.golangcilsp then
      local configs = require "lspconfig/configs"

      configs.golangcilsp = {
         default_config = {
            cmd = { "golangci-lint-langserver" },
            root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
            init_options = {
               command = { "golangci-lint", "run", "--out-format", "json" },
            },
         },
      }
   end

   lspconfig.gopls.setup {
      on_attach = attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
      flags = {
         debounce_text_changes = 150,
      },
      settings = {
         gopls = {
            gofumpt = true,
            experimentalPostfixCompletions = true,
            staticcheck = true,
            usePlaceholders = true,
         },
      },
   }

   lspconfig.elixirls.setup {
      cmd = { "/usr/bin/elixir-ls" },
   }

   lspconfig.golangcilsp.setup {
      filetypes = { "go" },
   }
end

return M
