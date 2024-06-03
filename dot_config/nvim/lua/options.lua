require "nvchad.options"

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.cmdheight = 1
vim.scrolloff = 10
vim.opt.expandtab = true
vim.opt.showcmd = true
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ai = true
vim.opt.si = true
vim.opt.wrap = false
vim.opt.backspace = "start,eol,indent"
vim.opt.path:append { "**" }
vim.opt.wildignore:append { "*/node_modules/*,*/.history/*" }

vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.formatoptions:append { "r" }

vim.opt.clipboard:append { "unnamedplus" }

vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true
vim.opt.mouse = ""

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
