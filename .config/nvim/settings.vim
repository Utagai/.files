lua <<EOF
-- Settings...

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear or become resolved.
vim.opt.signcolumn = 'yes'
-- Don't show any messages when we are using a completion menu.
vim.opt.shortmess = 'atTc'
EOF

" Sets folding behaviors
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set textwidth=0

" converts our use of tab into some number(2) of spaces
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Always show statusline
set laststatus=2

" Allows vim to the set the title to whatever the titlestring is. See
" commands.vim for how we set that.
" This is the last piece of the puzzle that enables tmux to give useful names
" to each of its windows containing a running vim instance.
set title

" Increase the yank buffer size
set viminfo='50,<1000,s100,h

" Make vim write its files to a universal location to avoid tarnishing the
" working directory, even if its with hidden files.
set nobackup
set noswapfile
