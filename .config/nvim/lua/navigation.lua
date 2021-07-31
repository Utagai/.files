-- Follow ctrlp keybinds.
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF +m --cycle --bind tab:down,btab:up<cr>', { silent = true })

-- Preview window.
vim.g.fzf_preview_window = {'bottom:30%'}

-- Disables some fzf command that I absolutely despise.
vim.api.nvim_command('command! -nargs=* W w')

-- Command for git grep, taken from fzf.vim's README.
vim.api.nvim_command(
"command! -bang -nargs=* GGrep " ..
"call fzf#vim#grep(" ..
  "'git grep --line-number '.shellescape(<q-args>), 0," ..
  "{" ..
    "'dir': systemlist('git rev-parse --show-toplevel')[0]," ..
    "'options': ['--bind', 'tab:down,btab:up', '+m', '--cycle']" ..
  "}, 0)"
)
-- Binds the above command to <C-s>.
vim.api.nvim_set_keymap('n', '<C-s>', ':GGrep<cr>', { silent = true })
