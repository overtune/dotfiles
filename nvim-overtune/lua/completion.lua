-- Built-in completion (Nvim 0.12), no plugins.
--
-- Buffers with a language server: the server's suggestions open as you type
-- (set up on LspAttach in plugins/enabled/nvim-lspconfig.lua).
-- Other buffers: 'autocomplete' suggests words from open buffers.
--
-- Keys while the menu is open:
--   <Tab> / <S-Tab>   next / previous suggestion
--   <CR>              accept the selected suggestion (a new line if none is selected)
--   <C-e>             close the menu
--   <C-Space>         open the menu by hand
-- In a snippet, <Tab> / <S-Tab> jump between its placeholders.

vim.o.autocomplete = true
vim.o.complete = ".^5,w^5,b^5"
-- noselect: nothing is picked until you press <Tab>, so <CR> keeps making
-- new lines. noinsert: <Tab> only highlights; <CR> inserts, so LSP snippets
-- and auto-imports are applied. popup: show the docs of the selected item.
-- fuzzy: match "fbr" against "foo_bar".
vim.o.completeopt = "menuone,noselect,noinsert,popup,fuzzy"
vim.o.pumheight = 15

local function pum_selected()
	return vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1
end

vim.keymap.set("i", "<CR>", function()
	if pum_selected() then
		return vim.keycode("<C-y>")
	end
	-- With the menu open but nothing selected, <CR> would only close the
	-- menu, so close it with <C-e> first and then break the line.
	local close = vim.fn.pumvisible() == 1 and vim.keycode("<C-e>") or ""
	-- Let nvim-autopairs split `{|}` over three lines.
	local ok, autopairs = pcall(require, "nvim-autopairs")
	return close .. (ok and autopairs.autopairs_cr() or vim.keycode("<CR>"))
end, { expr = true, replace_keycodes = false, desc = "Accept completion or new line" })

-- Inside a snippet the menu often reopens while you type in a placeholder.
-- Until you pick an item there, <Tab> jumps to the next placeholder
-- (use <C-n> / <C-p> to move through the menu instead).
local function tab(direction, pum_key, fallback)
	return function()
		local in_snippet = vim.snippet.active({ direction = direction })
		if vim.fn.pumvisible() == 1 and not (in_snippet and not pum_selected()) then
			return pum_key
		elseif in_snippet then
			local close = vim.fn.pumvisible() == 1 and "<C-e>" or ""
			return close .. ("<Cmd>lua vim.snippet.jump(%d)<CR>"):format(direction)
		end
		return fallback
	end
end

vim.keymap.set({ "i", "s" }, "<Tab>", tab(1, "<Down>", "<Tab>"), { expr = true, desc = "Next completion / snippet placeholder" })
vim.keymap.set({ "i", "s" }, "<S-Tab>", tab(-1, "<Up>", "<S-Tab>"), { expr = true, desc = "Previous completion / snippet placeholder" })

vim.keymap.set("i", "<C-Space>", function()
	if next(vim.lsp.get_clients({ bufnr = 0, method = "textDocument/completion" })) then
		vim.lsp.completion.get()
	else
		vim.api.nvim_feedkeys(vim.keycode("<C-n>"), "n", false)
	end
end, { desc = "Open completion menu" })
