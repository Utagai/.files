" Commands, command maps and autocommands.

autocmd FileType go match OverLength /\%>120v.\+/

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Trim trailing whitespace before we write
autocmd BufWritePre * %s/\s\+$//e
" Set the terminal title to the currently open file, helps with tmux window
" naming
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
" Add a shortcut command for copying the current buffer contents to the system
" clipboard.
command! Copy w !co.py
