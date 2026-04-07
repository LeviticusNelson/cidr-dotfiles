return {
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      presets = {
        command_palette = false,
        inc_rename = true,
        lsp_doc_border = true,
      },
      lsp = {
        progress = {
          enabled = true,
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      render = "minimal",
      stages = "static",
    },
  },
}
