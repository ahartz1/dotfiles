----------------------------------------
-- EARLY SETTINGS
----------------------------------------
-- Basic display settings
vim.opt.number = true
vim.opt.splitright = false
vim.opt.splitbelow = false
vim.opt.showmode = false

----------------------------------------
-- FILE HANDLING
----------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = false

----------------------------------------
-- EDITOR BEHAVIOR
----------------------------------------
-- Basic editing
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.shortmess:append("c")

-- Search settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

if vim.fn.executable('ag') == 1 then
    -- Use Ag over Grep
    vim.o.grepprg = "ag --nogroup --nocolor"
end

-- Indentation
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Display
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "-" }
vim.opt.ruler = true
vim.opt.scrolloff = 3
vim.opt.showmatch = true
vim.opt.signcolumn = "yes"
vim.opt.title = true

----------------------------------------
-- WINDOW AND BUFFER HANDLING
----------------------------------------
vim.opt.winwidth = 88
vim.opt.foldenable = false
vim.opt.equalalways = false

-- Format options
if vim.version().minor > 703 then
  vim.opt.formatoptions:append("j")
end
vim.opt.joinspaces = false
vim.opt.lazyredraw = true

----------------------------------------
-- COMPLETION AND TAGS
----------------------------------------
vim.opt.tags = "tags;"
if vim.fn.exists("&tagcase") == 1 then
  vim.opt.tagcase = "match"
end
vim.opt.completeopt = "longest,menuone"

----------------------------------------
-- PATH SETTINGS
----------------------------------------
vim.opt.path:append("**")
if vim.fn.getcwd() == vim.fn.expand("$HOME") .. "/.dotfiles" then
  vim.opt.path:append(vim.fn.expand("$HOME") .. "/.dotfiles/.bash")
  vim.opt.path:append(vim.fn.expand("$HOME") .. "/.dotfiles/.tmux")
  vim.opt.path:append(vim.fn.expand("$HOME") .. "/.dotfiles/.vim")
end

----------------------------------------
-- TIMEOUT SETTINGS
----------------------------------------
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.updatetime = 300

----------------------------------------
-- CURSOR SETTINGS
----------------------------------------
vim.opt.guicursor = {
  "n-v-c:block", -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar
  "r-cr:hor20", -- Replace: horizontal bar
  "o:hor50", -- Operator-pending: horizontal bar
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block with different blink
}

-- Prevent blinking cursor in GUI
vim.opt.guicursor:append("a:blinkon0")

----------------------------------------
-- FILETYPE SETTINGS
----------------------------------------
vim.cmd("filetype plugin indent on")

----------------------------------------
-- TERMINAL SETTINGS
----------------------------------------
-- Enable mouse in tmux
if vim.fn.has("mouse_sgr") == 1 then
  vim.opt.ttymouse = "sgr"
elseif vim.env.TERM:match("^screen") then
  vim.opt.ttymouse = "xterm2"
end

-- Return the module
return {}
