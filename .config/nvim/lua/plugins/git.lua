return {
  -- Git commands
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<Leader>gb", ":Git blame<CR>", desc = "Git blame" },
      { "<Leader>gs", ":Git<CR>", desc = "Git status" },
      { "<Leader>gc", ":Git commit -v<CR>", desc = "Git commit" },
    },
    config = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "fugitive://*",
        command = "set bufhidden=delete",
      })
    end,
  },

  -- Git signs in the gutter
  {
    "airblade/vim-gitgutter",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      vim.g.gitgutter_preview_win_floating = 0
      if vim.fn.executable("ag") == 1 then
        vim.g.gitgutter_grep = "ag"
      end
    end,
  },
}
