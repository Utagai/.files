-- Commands, command maps and autocommands.
-- These guys have to use `nvim_command` unfortunately, because there is no API
-- yet for autocmds and such.

-- Allow saving of files as sudo when I forgot to start vim using sudo.
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', {})

-- Trim trailing whitespace before we write
-- TODO: API for defining auto commands not yet in lua neovim.
vim.api.nvim_command('autocmd BufWritePre * %s/\\s\\+$//e')

-- Set the terminal title to the currently open file, helps with tmux window
-- naming
-- TODO: API for defining auto commands not yet in lua neovim.
vim.api.nvim_command('autocmd BufEnter * let &titlestring = \' \' . expand("%:t")')

-- Add a shortcut command for copying the current buffer contents to the system
-- clipboard.
-- TODO: API for defining user commands not yet in lua neovim.
vim.cmd('command! Copy w !co.py')
