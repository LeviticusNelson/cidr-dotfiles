-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.fillchars:append({ eob = " " })
vim.opt.cmdheight = 2

vim.treesitter.language.register("html", "htmldjango")
vim.o.termguicolors = true

vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns)

vim.g.clipboard = "osc52"
vim.opt.clipboard = "unnamedplus"
