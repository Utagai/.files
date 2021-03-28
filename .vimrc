if has('nvim')
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Surrounding quickies.
Plug 'tpope/vim-surround'
" Enables auto parens, bracket, quote, etc completion
Plug 'jiangmiao/auto-pairs'

" pretty hacker boy bar
Plug 'vim-airline/vim-airline'
" allows for theming the airline bar
Plug 'vim-airline/vim-airline-themes'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-rust-analyzer', 'coc-json', 'coc-tsserver' ]

" Vim git
Plug 'tpope/vim-fugitive'

" Fuzzy finder for vim
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" better Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'Twinside/vim-hoogle'
" better typescript
Plug 'leafgarland/typescript-vim'
" better typescriptreact
Plug 'peitalin/vim-jsx-typescript'
" Plug 'parsonsmatt/intero-neovim'
" better terraform
Plug 'hashivim/vim-terraform'
" better TOML
Plug 'cespare/vim-toml'
" better Swift syntax highlighting
Plug 'utagai/swift.vim'
" better js syntax
Plug 'pangloss/vim-javascript'
" adds extra C syntax highlighting
Plug 'justinmk/vim-syntax-extra'
" markdown syntax
Plug 'plasticboy/vim-markdown'
" extends vim support for fish syntax
Plug 'dag/vim-fish'
" Better i3 config/etc syntax highlighting
Plug 'mboughaba/i3config.vim'
" Use vim-go for easy improved Go syntax.
" This is unfortunate, because really I just want better syntax highlighting,
" and vim-go has the best one, but it can't be used outside the plugin. So I
" end up having to download the ENTIRE plugin.
Plug 'fatih/vim-go'
" Better Nim support
Plug 'zah/nim.vim'
" Better Rust support
Plug 'rust-lang/rust.vim'
" neodark colorscheme (vim only)
Plug 'KeitaNakamura/neodark.vim'
" my deep space colorscheme
Plug 'Utagai/vim-deep-space'

call plug#end()            " required

" CoC configuration
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Detect WSL.
if filereadable('/proc/sys/kernel/osrelease') && readfile('/proc/sys/kernel/osrelease')[0] =~# 'Microsoft'
  set guicursor=
endif

" Scroll with keyboard
function! FloatScroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    else
      let pos[0] = buf_height
    endif
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    else
      let pos[0] = 1
    endif
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

inoremap <silent><expr> <down> coc#util#has_float() ? FloatScroll(1) : "\<down>"
inoremap <silent><expr>  <up>  coc#util#has_float() ? FloatScroll(0) :  "\<up>"

" GoTo code navigation.
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> grn <Plug>(coc-rename)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<S-Tab>" :
      \ coc#refresh()

" enables autocomplete menu
set completeopt=menu

" Use dark colorscheme
set background=dark

if has('termguicolors')
  " keep the terminal bg what the terminal wants (i.e. transparent)
  set termguicolors
  let g:deepspace_italics=1
  let g:deepspace_transparent=1

  colorscheme deepspace
else
  colorscheme neodark
  " Below are 256 color options if we are ever on a terminal that doesn't
  " support true color:
  " Use 256 colours, disable if your terminal doesn't support 256.
  set t_Co=256
" Use whatever the terminal wants for our background.
  let g:neodark#terminal_transparent = 1
" Use 256 colors from neodark.
  let g:neodark#use_256color = 1
endif

" SO THIS IS KIND OF A HACK (if you are using fish or some other non bourne)
set shell=/bin/bash

" Sets folding behaviors
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" turns on syntax highlighting
syntax enable

" Set a little 80-width marker  ----------------------------------------------->X
highlight OverLength ctermbg=black ctermfg=blue
match OverLength /\%>80v.\+/
autocmd FileType go match OverLength /\%>120v.\+/

set textwidth=0

let g:airline_theme='deep_space'
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

" converts our use of tab into some number(2) of spaces
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Always show statusline
set laststatus=2

" Hit enter to clear highlights (from searches, usually)
nnoremap <CR> :noh<CR>
" Make search highlight colors much nicer on the eyes
hi Search cterm=NONE ctermfg=blue ctermbg=black
hi IncSearch cterm=NONE ctermfg=black ctermbg=blue
" Make the relative line number color(s) nicer on the eyes
highlight CursorLineNr term=bold ctermfg=blue ctermbg=None

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

" Set F2 to enable PASTE mode for copy-pasting code cleanly.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Let markdown live preview utilize grip.
let vim_markdown_preview_github=1
let g:vim_markdown_math=1

" Enable JSDocs highlighting
let g:javascript_plugin_jsdoc = 1

" Trim trailing whitespace before we write
autocmd BufWritePre * %s/\s\+$//e
" Set the terminal title to the currently open file, helps with tmux window
" naming
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" Disable folding because I don't use it and absolutely despise it
set nofoldenable

" Ensure that backspace works as expected
set backspace=indent,eol,start

" Increase the yank buffer size
set viminfo='50,<1000,s100,h

" Disable ex mode, lol.
nnoremap Q <nop>

" Show current line number
set number
" Show relative line numbers
set relativenumber
" Give us a command to quickly turn off/on line numbers if we want
command! Numbers set number | set relativenumber
command! Nonumbers set nonumber | set norelativenumber

highlight clear SignColumn

" Make vim split switches easier by directly using h, j, k, l to move
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Add a shortcut command for copying the current buffer contents to the system
" clipboard.
command! Copy w !co.py

" Make vim write its files to a universal location to avoid tarnishing the
" working directory, even if its with hidden files.
set nobackup
set noswapfile
set undodir=~/.vim/undo//

" Enable/disable certain features of vim-go:
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_fail_silently = 1
let g:go_def_mapping_enabled = 0
let g:go_def_mode = "godef"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_code_completion_enabled = 0
let g:go_gopls_enabled = 0

" follow ctrlp keybinds
nnoremap <silent> <C-p> :FZF +m --cycle --bind tab:down,btab:up<cr>

" hide the ugly statusline for the fzf terminal emulator window
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler number relativenumber

" make fzf pop up at the bottom
let g:fzf_layout = { 'down': '~20%' }

" Command for git grep, taken from fzf.vim's README.
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   {
  \     'dir': systemlist('git rev-parse --show-toplevel')[0],
  \     'options': ['--bind', 'tab:down,btab:up', '+m', '--cycle']
  \   }, <bang>0)

" map GGrep to CTRL+s
nnoremap <silent> <C-s> :GGrep<cr>

" Change the intero window size; default is 10.
let g:intero_window_size = 5
endif
