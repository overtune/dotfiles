-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<space>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<space>q", "<cmd>quit<cr>", { desc = "Exit" })
vim.keymap.set("n", "<space>r", "<cmd>ReloadConfig<cr>", { desc = "Reload config" })
vim.keymap.set("n", "<space>e", "<cmd>NvimTreeToggle<cr>", { desc = "Open NvimTree" })
vim.keymap.set("i", "jj", "<esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>kk", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>jj", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})
