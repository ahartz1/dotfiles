return {
  -- JavaScript/TypeScript support
  {
    "pangloss/vim-javascript",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      vim.g.javascript_plugin_jsdoc = 1
      vim.g.javascript_plugin_ngdoc = 1
    end,
  },

  -- TypeScript support
  {
    "leafgarland/typescript-vim",
    ft = { "typescript", "typescriptreact" },
  },

  -- JSX/TSX support
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascriptreact", "typescriptreact" },
  },

  -- HTML5 support
  {
    "othree/html5.vim",
    ft = { "html", "htmldjango" },
  },

  -- CSS support
  {
    "hail2u/vim-css3-syntax",
    ft = { "css", "scss", "sass" },
  },
}
