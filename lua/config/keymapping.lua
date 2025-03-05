local key=vim.keymap.set

--mapping
--basic
--change windows
key("n","<C-h>","<C-w>h")
key("n","<C-l>","<C-w>l")
key("n","<C-j>","<C-w>j")
key("n","<C-k>","<C-w>k")

--hurry up moving
key("n","<C-S-j>","7j")
key("n","<C-S-k>","7k")
key("n","<C-S-h>","7h")
key("n","<C-S-l>","7l")

--plugins
key("n","<leader>e","<cmd>NvimTreeToggle<CR>")
