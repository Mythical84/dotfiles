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
vim.g.maplocalleader = "\\"

require('lazy').setup({
	spec = {
		{ import='plugins' }
	},
	change_detection = {
		notify = false
	},
})

---------- LSP ----------
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('svelte')
vim.lsp.enable('pyright')

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

--[[
local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<TAB>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-TAB>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
      end
		end, { 'i', 's' }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name='nvim_lsp' }
	}, {
		{ name='buffer' },
	})
})
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})
require("cmp_git").setup()
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['rust_analyzer'].setup {
	capabilities = capabilities
}
require('lspconfig')['svelte'].setup {
	capabilities = capabilities
}
]]--

---------- Variables ----------
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false


-- Colorscheme
vim.cmd.colorscheme('onedark')
vim.cmd('highlight LineNr ctermfg=grey')
