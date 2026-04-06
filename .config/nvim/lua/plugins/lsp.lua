return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "htmldjango" },
        },
        taplo = {
          filetypes = { "toml" },
          -- IMPORTANT: this is required for taplo LSP to work in non-git repositories
          root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
        },
      },
      diagnostics = {
        virtual_text = false,
        virtual_lines = true,
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("lspconfig").clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--query-driver=/Applications/ArmGNUToolchain/14.3.rel1/arm-none-eabi/bin/arm-none-eabi-gcc,clang,gcc",
        },
      })
    end,
  },
}
