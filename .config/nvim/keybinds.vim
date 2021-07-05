" This file contains miscellaneous keybinds that have no thematic connection
" to other sourced vim files. For example, this means keybinds related to LSP
" functionality is in lsp.vim, not here. This file contains the randoms.

" Disable ex mode, lol.
nnoremap Q <nop>

" Set F2 to enable PASTE mode for copy-pasting code cleanly.
nnoremap <F2> :set invpaste paste?<CR>
" TODO: WTF?
set pastetoggle=<F2>

" Hit enter to clear highlights (from searches, usually)
nnoremap <C-l> :noh<CR>

" disable mouse
noremap <ScrollWheelUp>      <nop>
noremap <S-ScrollWheelUp>    <nop>
noremap <C-ScrollWheelUp>    <nop>
noremap <ScrollWheelDown>    <nop>
noremap <S-ScrollWheelDown>  <nop>
noremap <C-ScrollWheelDown>  <nop>
noremap <ScrollWheelLeft>    <nop>
noremap <S-ScrollWheelLeft>  <nop>
noremap <C-ScrollWheelLeft>  <nop>
noremap <ScrollWheelRight>   <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>
