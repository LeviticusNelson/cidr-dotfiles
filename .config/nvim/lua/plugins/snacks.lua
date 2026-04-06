require("lazyvim")
local header = [[
 __       ______   __   __ __   ______  __   ______   __  __   ______
/\ \     /\  ___\ /\ \ / //\ \ /\__  _\/\ \ /\  ___\ /\ \/\ \ /\  ___\
\ \ \____\ \  __\ \ \ \'/ \ \ \\/_/\ \/\ \ \\ \ \____\ \ \_\ \\ \___  \
 \ \_____\\ \_____\\ \__|  \ \_\  \ \_\ \ \_\\ \_____\\ \_____\\/\_____\
  \/_____/ \/_____/ \/_/    \/_/   \/_/  \/_/ \/_____/ \/_____/ \/_____/
           __   __   ______   __       ______   ______   __   __
          /\ "-.\ \ /\  ___\ /\ \     /\  ___\ /\  __ \ /\ "-.\ \
          \ \ \-.  \\ \  __\ \ \ \____\ \___  \\ \ \/\ \\ \ \-.  \
           \ \_\\"\_\\ \_____\\ \_____\\/\_____\\ \_____\\ \_\\"\_\
            \/_/ \/_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ \/_/

                           [ @LeviticusNelson ]                                ]]
return {
  {
    ---@module "snacks"
    "folke/snacks.nvim",
    optional = true,
    --@type snacks.dashboard.Item[]
    keys = {
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({
            current = false,
          })
        end,
        desc = "Buffers",
      },
    },
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = header,
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              action = ":lua Snacks.picker.pick('projects')",
              desc = "Projects",
              icon = " ",
              key = "p",
            },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          {
            section = "header",
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1,
            cmd = "hub status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
  },
}
