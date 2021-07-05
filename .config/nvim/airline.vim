" Don't show the Vim mode cause airline does that for us already
set noshowmode
let g:airline_theme='nord'
" allow vim to render utf-8 characters, allowing airline to be pretty and
" unicode files to render better.
set encoding=utf-8
let g:airline_powerline_fonts=1
" remove the certain airlinel parts we don't care about
" Includes the file encoding/format section, percentage section, whitespace
let g:airline_section_y=''
let g:airline_section_z='☰  %l/%L  : ⮁ %c'
" remove separators for empty sections remove separators for empty sections
let g:airline_skip_empty_sections = 1
" show buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Allow us to quickly toggle the buffer
nnoremap <silent> <leader>b :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
" Start vim without buffer line, because usually we don't want it immediately.
autocmd VimEnter * set showtabline=0
