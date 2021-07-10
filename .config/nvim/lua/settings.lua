-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear or become resolved.
vim.opt.signcolumn = 'yes'
-- Don't show any messages when we are using a completion menu.
vim.opt.shortmess = 'atTc'
-- Fold method should be manual.
vim.opt.foldmethod = 'manual'

-- I believe this only affects things like comments or text files..., for
-- which having this as my width is pretty good for my personally at least.
vim.opt.textwidth = 80

-- Tab/Spaces settings
-- TODO: We may want to add some autocmd overrides for Go...
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Always show statusline.
vim.opt.laststatus = 2

-- Allows vim to the set the title to whatever the titlestring is. See
-- commands.vim for how we set that.
-- This is the last piece of the puzzle that enables tmux to give useful names
-- to each of its windows containing a running vim instance.
vim.opt.title = true

-- Increase the yank buffer size.
vim.opt.viminfo = '\'50,<1000,s100,h'

-- Disable backup/swapfiles. I don't care, having things on a remote repo is
-- good enough and I have never had issues with PC/laptop dying or losing lots
-- of work... it's a risk but I don't care.
vim.o.backup = false
vim.g.writebackup = false
vim.bo.swapfile = false
