return {
  {
    "ray-x/web-tools.nvim",
    opts = {
      keymaps = {
        rename = nil,
        repeat_rename = ".",
      },
      hurl = {
        show_headers = false,
        floating = false,
        json5 = true,
        formatters = {
          json = { "jq" },
          html = { "prettier", "--parser", "html" },
        },
      },
    },
  },
}
