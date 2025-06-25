-- Remap movement keys
vim.keymap.set({ 'n', 'v', 'o' }, 'j', 'h', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'k', 'k', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'l', 'j', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, ';', 'l', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '^', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'h', '$', { noremap = true })

-- Press jj in insert mode to exit to normal mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

-- Map <Del> to <Esc> in normal, insert, and visual modes
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<A-m>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<A-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>h', opts) -- move to left window
vim.keymap.set('n', '<A-k>', '<C-w>k', opts) -- move to top window
vim.keymap.set('n', '<A-l>', '<C-w>j', opts) -- move to bottom window
vim.keymap.set('n', '<A-;>', '<C-w>l', opts) -- move to right window
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '+','<C-w>o', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = "Close current buffer" })
vim.keymap.set('n', '<leader>Q', '<cmd>bd!<CR>', { desc = "Force close current buffer" })

-- V
vim.keymap.set('n', '<A-v>', '<C-v>', opts)

-- copy 
vim.keymap.set('n', '<leader>y', function()
  -- Get content from register 0 (last yank)
  local content = vim.fn.getreg('"0')
  if content == '' then
    vim.notify('Register 0 is empty', vim.log.levels.WARN)
    return
  end

  -- Replace newlines with placeholder
  local formatted = content:gsub('\n', '<NEWLINE>')
  local histfile = vim.fn.expand('~/.cache/cliphist')

  -- Append to history file
  local file = io.open(histfile, 'a')
  if file then
    file:write(formatted .. '\n')
    file:close()
    vim.notify('Added to clipboard history', vim.log.levels.INFO)
  else
    vim.notify('Failed to write to history file', vim.log.levels.ERROR)
  end

  -- Also copy to system clipboard
  vim.fn.setreg('+', content)
end, { desc = 'Yank to clipboard history' })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 }) -- 200ms highlight
  end,
})


vim.api.nvim_create_user_command('ColorizerToggle',function()
	require('nvim-highlight-colors').toggle()
end,{})

-- lsp
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

