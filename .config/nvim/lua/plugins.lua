-- Configures plugins.

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Surrounding quickies.
  use 'tpope/vim-surround'

  -- Closes brackets for me.
  use 'jiangmiao/auto-pairs'

  -- Airline status bar.
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- LSP & Autocompletion.
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'

  -- Linting.
  use 'dense-analysis/ale'

  -- Git in vim.
  use 'tpope/vim-fugitive'

  -- Finder.
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Better fish script editing.
  use 'dag/vim-fish'
  -- Better terraform.
  use 'hashivim/vim-terraform'
  -- Better markdown syntax.
  use 'plasticboy/vim-markdown'
  -- Better i3 config/etc syntax highlighting.
  use 'mboughaba/i3config.vim'

  -- Nord colorscheme, but with some personal tweaks.
  use 'Utagai/nord-vim'
  -- Treesitter for better syntax highlighting.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
