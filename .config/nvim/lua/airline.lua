-- Don't show the Vim mode cause airline does that for us already.
vim.opt.showmode = false

------------- Airline configuration -------------
vim.g.airline_theme = 'nord'
vim.g.airline_powerline_fonts = 1

-- Configure airline sections.
-- Includes the file encoding/format section, percentage section, whitespace.
vim.g.airline_section_y=''
-- Customize the last section (not including error, etc section) to include
-- percentage through the file and column number.
vim.g.airline_section_z='☰  %l/%L %3p%% ⇌ %c'
-- Remove separators for empty sections which we don't care about.
vim.g.airline_skip_empty_sections = 1

-- Enable the buffer tabline for showing our vim buffers. Useful for when were
-- are descending down the stack in code and need to get way back up.
vim.g["airline#extensions#tabline#enabled"] = 1
-- Show the buffers, that's all we care about.
vim.g["airline#extensions#tabline#show_buffers"] = 1
-- And their number, since that is important.
vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
-- Stop showing whitespace errors. We use formatters for our languages that fix
-- this for us, as well as an autocmd.
vim.g["airline#extensions#whitespace#enabled"] = 0
-- Makes it so that the names of each buffer is as short as possible.
-- It only shows the filename, but if there are conflicts, will show an
-- abbreviated full path.
vim.g["airline#extensions#tabline#formatter"] = 'unique_tail_improved'
-- Start vim without buffer line, because usually we don't want it immediately.
-- TODO: API for defining auto commands not yet in lua neovim.
vim.api.nvim_command('autocmd VimEnter * set showtabline=0')
-- Allow us to quickly toggle the buffer tabline.
-- Note that we are using `nvim_exec()` here. This is because we couldn't get
-- this keybind working in Lua for some reason, the updates to `showtabline` were
-- not persisting...
vim.cmd(
  'nnoremap <silent> <leader>b :execute \'set showtabline=\' . (&showtabline ==# 0 ? 2 : 0)<CR>'
)
