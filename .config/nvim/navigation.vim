lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        preview_height = 0.8,
      },
    },
  }
}

-- Find files using Telescope command-line sugar.
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope git_files<CR>', { noremap = true, silent = true })
EOF
