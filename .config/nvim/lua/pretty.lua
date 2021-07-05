-- All all things pretty related, or in other words: syntax highlighting and
-- some number column stuff.

-- Enable Treesitter highlighting.
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
-- TODO: I am doing this because vim.g.syntax = 'enable' doesn't seem to work...
vim.cmd('syntax enable')
vim.opt.termguicolors = true
-- TODO: No lua-native colorscheme setting.
vim.cmd('colorscheme nord')

-- Show current line number
vim.opt.number = true
-- Show relative line numbers.
vim.opt.relativenumber = true

-- Clear the sign column, otherwise an ugly solid colored column appears to the
-- left.
-- TODO: No lua-native color setting.
vim.cmd('highlight clear SignColumn')

-- Give us commands to quickly turn off/on line numbers if we want.
vim.cmd('command! Numbers set number | set relativenumber')
vim.cmd('command! Nonumbers set nonumber | set norelativenumber')
