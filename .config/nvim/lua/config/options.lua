-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set Default terminal to ZSH
LazyVim.terminal.setup("zsh")

-- Global LSP definitions to accept custom text width
vim.opt.textwidth = 120

-- Enable full range colours
vim.opt.termguicolors = true

-- Disable snacks animations
vim.g.snacks_animate = false

-- Markdown Preview Settings
-- NOTE: Make sure ufw allows 9001/tcp
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_open_ip = ""
vim.g.mkdp_port = "9001"
vim.g.mkdp_echo_preview_url = true
vim.g.mkdp_browser = "firefox"
