set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.config/nvim/lsp.vim
source ~/.config/nvim/navigation.vim
source ~/.config/nvim/pretty.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/commands.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/keybinds.vim
lua require('plugins')
