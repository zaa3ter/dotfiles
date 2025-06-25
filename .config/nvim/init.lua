vim.o.mouse = ""
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindenting
vim.g.mapleader = " "
vim.opt.signcolumn = "no"

require("keymaps")
require("config.lazy")



vim.diagnostic.config({
	virtual_text = true,   -- show inline text (under the line)
	signs = true,          -- show in sign column
	underline = true,      -- underline the error in code
	update_in_insert = false,
})

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Smart relative line numbers
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Set colorscheme
vim.cmd.colorscheme  "dracula"
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})


vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      if diagnostic.code == 6133 or diagnostic.code == 80001 then
        return nil  -- Hide unused var + ES module suggestions
      end
      return diagnostic.message
    end
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
	vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { noremap = true, silent = true })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

