----------------------------------------
-- HELPER FUNCTIONS
----------------------------------------
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

----------------------------------------
-- TAB MANAGEMENT
----------------------------------------
-- Track last active tab
vim.api.nvim_create_autocmd("TabLeave", {
  group = augroup("tab_tracking"),
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

----------------------------------------
-- FILETYPE SETTINGS
----------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_settings"),
  pattern = {
    "c",
    "conf",
    "crontab",
    "gitconfig",
    "go",
    "help",
    "html",
    "html.mustache",
    "htmldjango",
    "javascript",
    "json",
    "lua",
    "man",
    "markdown",
    "php",
    "python",
    "ruby",
    "sass",
    "scss",
    "sh",
    "snippets",
    "sql",
    "vim",
    "xml",
  },
  callback = function()
    local ft = vim.bo.filetype
    local settings = {
      c = { tabstop = 4, shiftwidth = 4 },
      conf = { tabstop = 4, shiftwidth = 4, softtabstop = 4 },
      gitconfig = { tabstop = 4, shiftwidth = 4, expandtab = false },
      go = { tabstop = 4, shiftwidth = 4, softtabstop = 4 },
      html = { tabstop = 2, shiftwidth = 2 },
      ["html.mustache"] = { tabstop = 2, shiftwidth = 2 },
      htmldjango = { shiftwidth = 2 },
      javascript = { tabstop = 2, shiftwidth = 2, softtabstop = 0, expandtab = true },
      json = { tabstop = 2, shiftwidth = 2 },
      lua = { tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true },
      php = { tabstop = 4, shiftwidth = 4 },
      python = { tabstop = 4, shiftwidth = 4, softtabstop = 4 },
      ruby = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
      sass = { tabstop = 2, shiftwidth = 2 },
      scss = { tabstop = 2, shiftwidth = 2 },
      sh = { tabstop = 2, shiftwidth = 2, softtabstop = 2 },
      snippets = { tabstop = 4, shiftwidth = 4, expandtab = false },
      sql = { tabstop = 4, shiftwidth = 4, softtabstop = 4 },
      vim = { tabstop = 4, shiftwidth = 4 },
      xml = { tabstop = 2, shiftwidth = 2 },
    }

    -- Apply settings for the current filetype
    if settings[ft] then
      for option, value in pairs(settings[ft]) do
        vim.opt_local[option] = value
      end
    end
  end,
})

----------------------------------------
-- SYNTAX HIGHLIGHTING
----------------------------------------
-- Automatically syntax highlight diffs and code blocks
vim.api.nvim_create_autocmd({ "BufWinEnter", "VimEnter" }, {
  group = augroup("diff_syntax"),
  pattern = "*",
  callback = function()
    vim.cmd([[call SyntaxRange#Include("^<<<<<<<", "^>>>>>>>", "diff", "Special")]])
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "VimEnter" }, {
  group = augroup("markdown_syntax"),
  pattern = { "*.md", "*.mdc" },
  callback = function()
    vim.cmd([[
      call SyntaxRange#Include('```bash', '```', 'bash', 'Comment')
      call SyntaxRange#Include('```html', '```', 'html', 'Comment')
      call SyntaxRange#Include('```javascript', '```', 'javascript', 'Comment')
      call SyntaxRange#Include('```js', '```', 'javascript', 'Comment')
      call SyntaxRange#Include('```json', '```', 'json', 'Comment')
      call SyntaxRange#Include('```jsx', '```', 'javascript', 'Comment')
      call SyntaxRange#Include('```python', '```', 'python', 'Comment')
      call SyntaxRange#Include('```sh', '```', 'bash', 'Comment')
      call SyntaxRange#Include('```sql', '```', 'sql', 'Comment')
      call SyntaxRange#Include('```vim', '```', 'vim', 'Comment')
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "VimEnter" }, {
  group = augroup("xml_syntax"),
  pattern = { "*.xml" },
  callback = function()
    vim.cmd([[call SyntaxRange#Include('<Sql>', '</Sql>', 'sql', 'xmlTagName')]])
  end,
})

----------------------------------------
-- CURSOR SETTINGS
----------------------------------------
-- Force cursor to underline in terminal mode
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = augroup("cursor_shape"),
  callback = function()
    vim.opt.guicursor = vim.opt.guicursor + "a:hor10"
  end,
})

-- Return the module
return {}
