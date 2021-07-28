-- Configures the LSP settings and autocompletion.

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  require'lsp_signature'.on_attach({
    hint_enable = false,
  })
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gk', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'cc', '<cmd>cc<CR>', opts)
  buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'g?', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  -- Stops diagnostics from spamming my screen when I haven't even finished
  -- typing yet.
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      -- Disable a feature
      update_in_insert = false,
    }
  )

  vim.fn.sign_define("LspDiagnosticsSignError", {text = "✗", texthl = "LspDiagnosticsDefaultError"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "❗", texthl = "LspDiagnosticsDefaultWarning"})
end

-- Quickfix window keybinds. These are technically general, but we only ever
-- really use this with our LSP stuff, so that's why it exists in lsp.vim.
vim.api.nvim_set_keymap('n', '<C-k>', ':cprev<CR>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>zz', { noremap = true, silent = true })
-- TODO: This bind causes errors if you press enter in normal mode.
vim.api.nvim_set_keymap('n', '<CR>', ':.cc<CR>:cclose<CR>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':cclose<CR>', { noremap = true, silent = true })

local servers = {'gopls', 'rust_analyzer'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

-- Only load compe stuff for LSP.
require'compe'.setup {
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
  };
}

-- How to match things in the completion menu.
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
-- Some options for how the completion menu should behave.
vim.opt.completeopt = {'menu', 'noinsert'}

-- Use Tab + ShiftTab to navigation the completion menu.
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
