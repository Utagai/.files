-- Packer.
require('plugins')

-- Colors, color schemes, etc.
-- NOTE: This has to be loaded first because it turns syntax on, which, if
-- turned on _after_ LSP's setup{}, messed with filetype autocmds and makes
-- everything broken and buggy.
require('pretty')

-- Neovim LSP
require('lsp')

-- ALE
require('ale')

-- Some command configuration.
require('commands')

-- Miscellaneous settings.
require('settings')

-- Keybinds.
require('keybinds')

-- Navigation/finder; i.e. Telescope.
require('navigation')

-- Airline bar.
require('airline')
