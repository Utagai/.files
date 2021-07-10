-- Contains options for configuring ALE.

-- Customizes the message given by ALE.
vim.g.ale_echo_msg_format = "%linter% says '%s'"

-- Set the fixer for certain file types.
vim.g.ale_fixers = {
  cpp = {'clang-format'};
  go = {'goimports'};
  haskell = {'brittany'};
  rust = {'rustfmt'};
}

-- Set the linters for certain file types.
vim.g.ale_linters = {
  go = {'golint'};
  haskell = {'hlint'};
}

-- Run the fixer(s) on save.
vim.g.ale_fix_on_save = true

-- Choose the symbols for warnings/errors.
vim.g.ale_sign_warning = '❗'
vim.g.ale_sign_error = '✗'

-- Lang-specific settings.
vim.g.ale_go_govet_options = '-composites=false'
vim.g.ale_rust_cargo_use_clippy = true
