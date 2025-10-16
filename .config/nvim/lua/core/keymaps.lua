----------------------------------------
-- HELPER FUNCTIONS
----------------------------------------
local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

----------------------------------------
-- BASIC OPERATIONS
----------------------------------------
-- Remap save (only if buffer has changed)
map("n", "<Leader>s", ":update<CR>")

-- Remap load
map("n", "<Leader>e", ":e!<CR>")
map("n", "<Leader>E", ":TabDo WinDo e!<CR>")

-- Remap escape in insert mode
map("i", "jj", "<ESC>")

----------------------------------------
-- WINDOW NAVIGATION
----------------------------------------
-- Make moving between windows easier
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

----------------------------------------
-- USER FUNCTIONS
----------------------------------------
-- Make navigating between folds a bit nicer
map("n", "z.", function()
  _G.ReadingHeight()
end, { silent = true })

map("n", "<LocalLeader>tw", function()
  _G.ToggleTextWidth()
end, { silent = true })

----------------------------------------
-- COMMAND MODE MAPPINGS
----------------------------------------
-- Make moving the cursor around in command mode like bash (Emacs)
vim.cmd([[
    cnoremap <C-a> <Home>
    cnoremap <C-f> <Right>
    cnoremap <C-b> <Left>
    cnoremap <Esc>b <S-Left>
    cnoremap <Esc>f <S-Right>
]])
----------------------------------------
-- SEARCH AND HIGHLIGHT
----------------------------------------
-- * and # search without jumping
map("n", "*", ":keepjumps normal! mi*`i<CR>")
map("n", "g*", ":keepjumps normal! mig*`i<CR>")
map("n", "#", ":keepjumps normal! mi#`i<CR>")
map("n", "g#", ":keepjumps normal! mig#`i<CR>")

-- Turn off highlighting of search
map("n", "<Leader>n", ":nohlsearch<CR>")

----------------------------------------
-- TAB MANAGEMENT
----------------------------------------
-- Switch to previously active tab
map("n", "<Leader>l", ':exe "tabn ".g:lasttab<CR>')

-- Switch to the last tab in the tabline
map("n", "<Leader>L", ":tabl<CR>")

-- Close a whole tab, no matter how many windows are in it
map("n", "<Leader>C", ":tabc<CR>")

-- Function that allows for a count when switching to next tab
local function aj_next_tab(count)
  local lasttab = vim.fn.tabpagenr()
  if count == 0 then
    count = 1
  end
  for _ = 1, count do
    vim.cmd("tabnext")
  end
  vim.g.lasttab = lasttab
end

-- Map to g<C-t>
vim.keymap.set("n", "g<C-t>", function()
  aj_next_tab(vim.v.count)
end, { silent = true })

----------------------------------------
-- VIMRC MANAGEMENT
----------------------------------------
-- Edit vimrc file
map("n", "<Leader>ve", ":vsplit $MYVIMRC<CR>")

-- Source vimrc file
map("n", "<Leader>vs", ":source $MYVIMRC<CR>:noh<CR>:AirlineRefresh<CR>")

----------------------------------------
-- SUDO WRITE
----------------------------------------
-- Save a file that requires sudo after already editing it
vim.cmd([[cnoremap w!! w !sudo tee % >/dev/null]])

----------------------------------------
-- DEBUGGING AND INSPECTION
----------------------------------------
-- Show the highlighting groups for the text under the cursor
local function show_highlight_group()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local hi = vim.fn.synID(line, col, 1)
  local trans = vim.fn.synID(line, col, 0)
  local lo = vim.fn.synIDtrans(hi)

  print(
    string.format(
      "hi<%s> trans<%s> lo<%s>",
      vim.fn.synIDattr(hi, "name"),
      vim.fn.synIDattr(trans, "name"),
      vim.fn.synIDattr(lo, "name")
    )
  )
end

map("n", "<LocalLeader>hl", show_highlight_group)

----------------------------------------
-- WINDOW AND SCREEN MANAGEMENT
----------------------------------------
-- Redraw the screen
map("n", "<Leader>r", ":redraw!<CR>:AirlineRefresh<CR>")

-- Force max height of window
map("n", "<Leader>R", ":TabDo :500wincmd _<CR> :TabDo :wincmd =<CR>")

----------------------------------------
-- TEXT MANIPULATION
----------------------------------------
-- Add a space on either side of the current cursor location
map("n", "<LocalLeader><Space>", ':execute "normal! i "<CR> :execute "normal! li "<CR>')

----------------------------------------
-- AVOID ACCIDENTAL HELP
----------------------------------------
-- Avoid accidentally triggering the help when reaching for Escape
map("i", "<F1>", "<ESC>")
map("n", "<F1>", "<ESC>")
map("v", "<F1>", "<ESC>")

---
-- SEARCH
---
-- Ack/Ag search commands
-- map("n", "<Leader>a", ":silent! Ack!<Space>-F<Space>", { silent = false })
map("n", "<Leader>A", ":tabe<CR>:silent! Ack<Space>-F<Space>", { silent = false })

-- Highlight `= f"""` in python strings as SQL
map(
  "n",
  "<LocalLeader>ps",
  [[:call SyntaxRange#Include('= f\?"""', '^\s*"""', 'sql', 'String')<CR>]],
  { silent = true }
)

-- Return the module
return {}
