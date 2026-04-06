return {
  {
    "jedrzejboczar/nvim-dap-cortex-debug",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      debug = false,
      extension_path = nil,
      lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
      node_path = "bun", -- path to node.js executable
      dapui_rtt = true, -- register nvim-dap-ui RTT element
      -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
      dap_vscode_filetypes = { "c", "cpp" },
      rtt = {
        buftype = "Terminal", -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
      },
    },
  },
}
