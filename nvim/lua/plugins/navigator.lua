return {
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({
        disable_on_zoom = false,
        auto_save = nil,
        mux = "auto",
      })
    end,
  },
}
