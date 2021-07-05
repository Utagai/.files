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
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Vim git
Plug 'tpope/vim-fugitive'

" Fuzzy finder for vim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" better fish script editing
Plug 'dag/vim-fish'
" better terraform
Plug 'hashivim/vim-terraform'
" markdown syntax
Plug 'plasticboy/vim-markdown'
" Better i3 config/etc syntax highlighting
Plug 'mboughaba/i3config.vim'
" Nord colorscheme, but with some personal tweaks.
Plug 'Utagai/nord-vim'

call plug#end()            " required
