-- This file contains miscellaneous keybinds that have no thematic connection
-- to other sourced vim files. For example, this means keybinds related to LSP
-- functionality is in lsp.vim, not here. This file contains the randoms.

-- Disable ex mode, lol.
vim.api.nvim_set_keymap('n', 'Q', '', {})

-- Set F2 to enable PASTE mode for copy-pasting code cleanly.
vim.api.nvim_set_keymap('n', '<F2>', ':set invpaste paste?<CR>', { silent = true })

-- Hit Ctrl+l to clear highlights (from searches, usually)
vim.api.nvim_set_keymap('n', '<C-l>', ':noh<CR>', { silent = true })

-- Disable the mouse.
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', '', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelUp>', '', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', '', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', '', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelDown> ', '', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown> ', '', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelLeft>', '', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelLeft> ', '', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelLeft> ', '', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelRight>', '', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelRight>', '', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelRight>', '', {})
