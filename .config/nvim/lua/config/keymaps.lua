-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.fn.environ()["TERM"] == "tmux-256color" then
  vim.keymap.set({ "n", "t" }, "<C-h>", "<Cmd>NavigatorLeft<CR>")
  vim.keymap.set({ "n", "t" }, "<C-j>", "<Cmd>NavigatorDown<CR>")
  vim.keymap.set({ "n", "t" }, "<C-k>", "<Cmd>NavigatorUp<CR>")
  vim.keymap.set({ "n", "t" }, "<C-l>", "<Cmd>NavigatorRight<CR>")
end

if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set(
    { "n" },
    "<leader>gg",
    "<Cmd>lua Snacks.lazygit({ cwd = Snacks.git.get_root(vim.fn.expand('%')) })<CR>"
  )
end
vim.keymap.set({ "n" }, "-", "<Cmd>Oil<CR>")
