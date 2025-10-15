-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin specifications
require("lazy").setup({
  -- Load plugin specs from separate files
  { import = "plugins.ai" }, -- AI tools
  { import = "plugins.ui" }, -- UI enhancements (NERDTree, airline, etc.)
  { import = "plugins.git" }, -- Git-related plugins
  { import = "plugins.editing" }, -- Editor enhancements (surround, repeat, etc.)
  { import = "plugins.lsp" }, -- LSP and completion
  { import = "plugins.lang" }, -- Language-specific plugins
  { import = "plugins.tools" }, -- Additional tools (fzf, ack, etc.)
}, {
  -- Lazy.nvim options
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      paths = {
        "~/.vim/.vimrc_add_ons",
        "~/.vim/autoload",
        "~/.vim/backups",
        "~/.vim/colors",
        "~/.vim/ftplugin",
        "~/.vim/my-snippets",
        "~/.vim/plugin",
        "~/.vim/spell",
        "~/.vim/swaps",
        "~/.vim/undo",
      },
    },
  },
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- Return the module
return {}
