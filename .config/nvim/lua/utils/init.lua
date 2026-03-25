----------------------------------------
-- TEXT ALIGNMENT
----------------------------------------
-- Align text around a pattern
function _G.AJIndent(pattern)
  -- Default indent column is 40 unless specified
  local indent_column = 40

  -- Use '=' as default pattern if none provided
  pattern = pattern or "="

  -- Get the range of lines to process
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Process each line in the range
  for line_num = start_line, end_line do
    -- Get the current line
    local line = vim.fn.getline(line_num)

    -- Find the position of the pattern
    local match_pos = vim.fn.match(line, "\\C" .. vim.fn.escape(pattern, "\\"))
    if match_pos ~= -1 then
      match_pos = match_pos + 1 -- Convert to 1-based index

      -- Check if there's a word character immediately before the pattern
      local char_before = vim.fn.strpart(line, match_pos - 2, 1)
      if char_before:match("%w") then
        -- Skip this line as it would break a word
        vim.api.nvim_echo({
          { "Line " .. line_num .. ": Pattern would break a word", "WarningMsg" },
        }, true, {})
        goto continue
      end

      -- Calculate needed spaces
      local current_text = vim.fn.strpart(line, 0, match_pos - 1)
      local current_width = vim.fn.strdisplaywidth(current_text)
      local spaces_needed = indent_column - current_width - 1

      if spaces_needed < 0 then
        vim.api.nvim_echo({
          {
            "Line "
              .. line_num
              .. ": Not enough space before pattern; min column: "
              .. tostring(current_width + 2),
            "WarningMsg",
          },
        }, true, {})
        goto continue
      end

      -- Create the new line
      local before_pattern = vim.fn.strpart(line, 0, match_pos - 1)
      local after_pattern = vim.fn.strpart(line, match_pos - 1)
      local new_line = before_pattern .. string.rep(" ", spaces_needed) .. after_pattern

      -- Replace the line
      vim.fn.setline(line_num, new_line)
    end

    ::continue::
  end
end

----------------------------------------
-- THEME MANAGEMENT
----------------------------------------
-- Toggle between light and dark background
function _G.BgToggle()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

----------------------------------------
-- WINDOW MANAGEMENT
----------------------------------------
-- Like windo but restore the current window
function _G.WinDo(command)
  local currwin = vim.fn.winnr()
  vim.cmd("windo " .. command)
  vim.cmd(currwin .. "wincmd w")
end

-- Like tabdo but restore the current tab
function _G.TabDo(command)
  local currTab = vim.fn.tabpagenr()
  vim.cmd("tabdo " .. command)
  vim.cmd("tabn " .. currTab)
end

----------------------------------------
-- READING AND NAVIGATION
----------------------------------------
-- Move current line to reading height
function _G.ReadingHeight()
  local win_height = vim.fn.winheight(0)
  local offset = math.floor(win_height / 4.0) - vim.opt.scrolloff:get()
  -- First move the line to top of window
  vim.cmd("normal! zt")
  -- Then scroll down by offset lines
  vim.cmd('execute "normal! ' .. offset .. '\\<C-Y>"')
end

----------------------------------------
-- SYNTAX INSPECTION
----------------------------------------
-- Show syntax stack under cursor
function _G.SynStack()
  if not vim.fn.exists("*synstack") == 1 then
    return
  end
  local syn_stack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
  local result = vim.fn.map(syn_stack, 'synIDattr(v:val, "name")')
  print(vim.inspect(result))
end

----------------------------------------
-- TEXT WIDTH MANAGEMENT
----------------------------------------
-- Toggle text width
function _G.ToggleTextWidth(new_width)
  new_width = new_width or 72
  if vim.o.textwidth == 0 then
    vim.o.textwidth = new_width
  else
    vim.o.textwidth = 0
  end
end

----------------------------------------
-- GIT UTILITIES
----------------------------------------
-- View diff of current file against branch
function _G.DiffBranchFile(diff_branch)
  diff_branch = diff_branch or "master"
  vim.cmd("diffthis")
  vim.cmd("Gvsplit " .. diff_branch .. ":%")
  vim.cmd("diffthis")
  vim.cmd("normal! w")
end

-- Create commands for WinDo and TabDo
vim.api.nvim_create_user_command("WinDo", function(opts)
  WinDo(opts.args)
end, { nargs = "+" })

vim.api.nvim_create_user_command("TabDo", function(opts)
  TabDo(opts.args)
end, { nargs = "+" })

-- Search commands
vim.api.nvim_create_user_command(
  "Pgrep",
  "grep -rn --include={*.php,} <args>",
  { nargs = "+" }
)
vim.api.nvim_create_user_command("Agrep", "grep -rn <args>", { nargs = "+" })

-- Return the module (empty since we're using _G)
return {}
