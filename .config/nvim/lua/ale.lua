-- Contains options for configuring ALE.

-- Customizes the message given by ALE.
vim.g.ale_echo_msg_format = "%linter% says '%s'"

-- Set the fixer for certain file types.
vim.g.ale_fixers = {
  cpp = {'clang-format'};
  go = {'goimports'};
  haskell = {'brittany'};
  rust = {'rustfmt'};
  javascript = {'prettier'};
  typescript = {'prettier'};
  typescriptreact = {'prettier'};
}

-- Set the linters for certain file types.
vim.g.ale_linters = {
  go = {'golint'};
  haskell = {'hlint'};
  typescript = {'eslint'};
  typescriptreact = {'eslint'};
}

-- Run the fixer(s) on save.
vim.g.ale_fix_on_save = 1

-- Choose the symbols for warnings/errors.
vim.g.ale_sign_warning = '!'
vim.g.ale_sign_error = '✗'

-- Lang-specific settings.
vim.g.ale_go_govet_options = '-composites=false'
vim.g.ale_rust_cargo_use_clippy = true

-- Keybinds for jumping to next/previous warnings/errors.
vim.api.nvim_set_keymap('n', 'ap', ':ALEPrevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'an', ':ALENext<CR>', { silent = true })
