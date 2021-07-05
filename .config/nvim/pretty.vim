" All all things pretty related, or in other words: syntax highlighting and
" some number column stuff.

" Turns on syntax highlighting.
syntax enable

" Enable Treesitter highlighting.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

set termguicolors
colorscheme nord


" ----- Line number stuff
" Show current line number
set number
" Show relative line numbers
set relativenumber
" Give us a command to quickly turn off/on line numbers if we want
command! Numbers set number | set relativenumber
command! Nonumbers set nonumber | set norelativenumber

highlight clear SignColumn
