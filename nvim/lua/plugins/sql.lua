local sql_ft = { "sql", "mysql", "plsql" }
return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "dadbod", "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local util = require("conform.util")
      opts.formatters.sqlfluff = {
        args = { "fix", "-" },
        stdin = true,
        cwd = util.root_file({
          ".sqlfluff",
          "pep8.ini",
          "pyproject.toml",
          "setup.cfg",
          "tox.ini",
        }),
        require_cwd = true,
      }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "sqlfluff")
      end
    end,
  },
}
