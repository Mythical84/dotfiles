-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
		os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.localmapleader = "\\"
require('lazy').setup({
	spec = {
		{ import='plugins' }
	},
	change_detection = {
		notify = false
	},
})

require('snippets')

---------- LSP ----------
local rust = "rust_analyzer"
local java = "java_language_server"
vim.lsp.enable(rust)     --rust
vim.lsp.enable('svelte')   --svelte
vim.lsp.enable('pyright')  --python
vim.lsp.enable('lua_ls')   --lua
vim.lsp.enable('clangd')   --c
vim.lsp.enable('cssls')    --css
vim.lsp.enable(java)		 --java

---------- Variables ----------
vim.opt.number = true
vim.opt.splitbelow = true
vim.o.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.o.conceallevel = 1
vim.o.concealcursor = 'n'

vim.cmd("autocmd Filetype python setlocal tabstop=2 shiftwidth=2 noexpandtab")

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python' },
	callback = function()
		vim.cmd([[setlocal noexpandtab tabstop=2 shiftwidth=2]])
	end
})

-- Open terminal
vim.cmd([[
	enew
	term
	bp
]])

-- Colorscheme
vim.cmd.colorscheme('catppuccin-mocha')
vim.cmd('highlight LineNr ctermfg=grey')

-- Activate treesitter
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python', 'svelte', 'typescript', 'rust', 'lua' },
	callback = function()
		vim.treesitter.start()
	end,
})

-- Split keybinds
vim.keymap.set({'i', 'n'}, '<c-l>', '<cmd>:vert sb<cr><c-w><c-l><cmd>:enew<cr>:e ', {noremap=true})
vim.keymap.set({'i', 'n'}, '<c-h>', '<cmd>:vert sb<cr><cmd>:enew<cr>:e ', {noremap=true})
vim.keymap.set({'i', 'n'}, '<c-j>', '<cmd>:split<cr><cmd>:enew<cr>:e ', {noremap=true})
vim.keymap.set({'i', 'n'}, '<c-k>', '<cmd>:split<cr><c-w><c-k><cmd>:enew<cr>:e ', {noremap=true})

local function open_float()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(0, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.cmd([[
    b /usr/bin/fish
    startinsert
  ]])

  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>:close<CR>", { nowait=true, noremap=true, silent=true })
  vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<cmd>:close<CR>", { nowait=true, noremap=true, silent=true })
end

vim.keymap.set("n", "<leader>t", open_float, {noremap=true})

vim.keymap.set({'i'}, '<Enter>', function ()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local char_before = line:sub(col, col)
  local char_after = line:sub(col+1, col+1)
  if char_before == "{" and char_after == "}" then
    return "\n<Esc>k$a<Enter>"
  end
  return "\n"
end, {expr=true})

vim.keymap.set('n', '<leader>fs', '<cmd>:e .<CR>', {noremap=true})

vim.api.nvim_create_user_command('Q', function ()
  while true do
		if vim.bo.buftype == '' then
			vim.cmd('w')
		end
		vim.cmd('q')
	end
end, {nargs=0})

if vim.fn.argc(-1) == 0 then
	vim.cmd("e .")
end
