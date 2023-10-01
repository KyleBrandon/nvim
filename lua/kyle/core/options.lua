vim.cmd.filetype = "plugin on"
vim.cmd.syntax = "on"

-- set leader key to spacea
vim.g.mapleader = " "

local opt = vim.opt -- for conciseness

opt.rtp:append("/opt/homebrew/opt/fzf")

opt.nu = true
opt.relativenumber = true

-- tabs and indents
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- search optionms
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.incsearch = true -- show search matches as you type
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line
opt.list = true -- show some invisible characters (tabs...)
opt.listchars = { tab = "»·", trail = "·", nbsp = "␣" } -- set invisible characters

-- appearance

-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.scrolloff = 8 -- set a scroll offset of 8 lines
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
-- opt.highlight.CopilotSuggestion(guifg=#555555 ctermfg=8)

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
