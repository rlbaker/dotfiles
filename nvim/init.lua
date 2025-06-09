vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = "no"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.switchbuf = { "useopen", "uselast" }
vim.opt.updatetime = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.foldenable = false
-- vim.opt.foldlevelstart = 99

vim.g.html_indent_autotags = "html"
vim.g.loaded_python3_provider = 0

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git", "clone", "--filter=blob:none", "--single-branch",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup { { import = "plugins" } }

vim.cmd.colorscheme("catppuccin-macchiato")

local rlb = vim.api.nvim_create_augroup("rlb", { clear = true })
vim.api.nvim_create_autocmd("FileType", { group = rlb, pattern = "*", command = [[ set fo-=cro ]] })
vim.api.nvim_create_autocmd("FileType", { group = rlb, pattern = "go", command = [[ set noet ]] })
vim.api.nvim_create_autocmd("FileType", { group = rlb, pattern = "lua", command = [[ set ts=2 sts=2 sw=2 ]] })

vim.diagnostic.config({ virtual_lines = { current_line = true } })

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function() return hover({ border = "rounded" }) end

local function desc(s) return { desc = s } end
local function cmd(s) return "<CMD>" .. s .. "<CR>" end

-- Custom
vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, desc("Completion"))
vim.keymap.set("n", "\\", cmd("noh"), { desc = "Clear Search Highlights" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave Terminal Input Mode" })
vim.keymap.set("n", "<C-;>", "A;<Esc>", { desc = "Add Semicolon" })
vim.keymap.set("i", "<C-;>", "<C-o>A;", { desc = "Add Semicolon" })
vim.keymap.set("i", "<C-Enter>", "<C-y>", { desc = "Expand Completion" })

vim.keymap.set("n", "<Leader><Leader>", function() Snacks.picker.buffers({ current = false }) end, desc("Buffer List"))
vim.keymap.set("n", "<Leader>.", function() Snacks.picker.files() end, desc("List Files"))
vim.keymap.set("n", "<Leader>e", function() Snacks.explorer() end, desc("File Explorer"))
vim.keymap.set("n", "<Leader>h", function() Snacks.picker.help() end, desc("Help"))
vim.keymap.set("n", "<Leader>t", function() Snacks.picker.treesitter() end, desc("Treesitter"))
vim.keymap.set("n", "<Leader>p", function() Snacks.picker() end, desc("Pickers"))
vim.keymap.set("n", "<Leader>s", cmd("lua MiniTrailspace.trim()"), desc("Trim Trailing Whitespace"))

-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, desc("LSP: Go to definition"))
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, desc("LSP: Go to declaration"))
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, desc("LSP: Go to type definition"))
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, desc("LSP: Go to implementation"))
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, desc("LSP: Show references"))
vim.keymap.set("n", "gR", vim.lsp.buf.rename, desc("LSP: Rename"))
vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, desc("LSP: Find symbol in file"))
vim.keymap.set("n", "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc("LSP: Find symbol in workspace"))
vim.keymap.set("n", "gn", function() Snacks.words.jump(1, true) end, desc("LSP: Next occurrence"))
vim.keymap.set("n", "gp", function() Snacks.words.jump(-1, true) end, desc("LSP: Previous occurrence"))
vim.keymap.set("n", "gF", function() vim.lsp.buf.format({ async = true }) end, desc("LSP: Format Document"))
vim.keymap.set("n", "g.", vim.lsp.buf.code_action, desc("LSP: Code actions"))
vim.keymap.set("i", "<C-a>", vim.lsp.buf.code_action, { desc = "LSP: Code Actions" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Diagnostics
vim.keymap.set("n", "<Leader>d", function() Snacks.picker.diagnostics_buffer() end, desc("Buffer Diagnostics"))
vim.keymap.set("n", "<Leader>D", function() Snacks.picker.diagnostics() end, desc("Diagnostics"))
vim.keymap.set("n", "gh", vim.diagnostic.open_float, desc("Show diagnostic"))
vim.keymap.set("n", "g]", function() vim.diagnostic.jump({ count = vim.v.count1 }) end, desc("Next Diagnostic"))
vim.keymap.set("n", "g[", function() vim.diagnostic.jump({ count = -vim.v.count1 }) end, desc("Prev Diagnostic"))
