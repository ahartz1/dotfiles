return {
  -- Tim Pope's essential plugins
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "tpope/vim-obsession",
    lazy = false,
    cmd = { "Obsession" },
  },

  -- EditorConfig support
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Improved matchit
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Syntax range
  {
    "inkarkat/vim-ingo-library",
    lazy = false,
  },
  {
    "inkarkat/vim-SyntaxRange",
    dependencies = { "inkarkat/vim-ingo-library" },
    lazy = false,
    config = function()
      vim.cmd(
        "source "
          .. vim.fn.stdpath("data")
          .. "/lazy/vim-SyntaxRange/autoload/SyntaxRange.vim"
      )
    end,
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>gq",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}
