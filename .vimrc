if has('nvim')
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Surrounding quickies.
Plug 'tpope/vim-surround'
" Closes brackets for me.
Plug 'jiangmiao/auto-pairs'

" pretty hacker boy bar
Plug 'vim-airline/vim-airline'
" allows for theming the airline bar
Plug 'vim-airline/vim-airline-themes'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Vim git
Plug 'tpope/vim-fugitive'

" Fuzzy finder for vim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" better terraform
Plug 'hashivim/vim-terraform'
" markdown syntax
Plug 'plasticboy/vim-markdown'
" Better i3 config/etc syntax highlighting
Plug 'mboughaba/i3config.vim'
" my deep space colorscheme
Plug 'Utagai/vim-deep-space'
Plug 'arcticicestudio/nord-vim'

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

" Treesitter enable highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" -------------------- LSP ---------------------------------
lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gk', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    vim.fn.sign_define("LspDiagnosticsSignError", {text = "X", texthl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "!", texthl = "LspDiagnosticsDefaultWarning"})
  end

  local servers = {'gopls', 'rust_analyzer'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        preview_height = 0.8,
      },
    },
  }
}
EOF

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set completeopt=menu,noinsert
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" -------------------- LSP ---------------------------------

" Use dark colorscheme
set background=dark

set termguicolors
" let g:deepspace_italics=1
" let g:deepspace_transparent=1
colorscheme nord

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

" Find files using Telescope command-line sugar.
nnoremap <silent> <C-s> :Telescope live_grep<cr>
nnoremap <silent> <C-p> :Telescope git_files<cr>
endif
