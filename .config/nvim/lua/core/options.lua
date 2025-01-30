----------------------------------------
-- EARLY SETTINGS
----------------------------------------
-- Basic display settings
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true

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
vim.opt.mouse = "a"
vim.opt.cursorline = true

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

if vim.fn.executable('ag') == 1 then
    -- Use Ag over Grep
    vim.o.grepprg = "ag --nogroup --nocolor"
end

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Display
vim.opt.listchars = { tab = "▸ ", trail = "-" }
vim.opt.list = true
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.title = true
vim.opt.scrolloff = 3
vim.opt.showmatch = true

----------------------------------------
-- WINDOW AND BUFFER HANDLING
----------------------------------------
vim.opt.winwidth = 88
vim.opt.foldenable = false

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
