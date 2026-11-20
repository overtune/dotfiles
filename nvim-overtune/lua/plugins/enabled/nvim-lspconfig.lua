-- Language servers. nvim-lspconfig only ships the server definitions
-- (lsp/<name>.lua); starting them uses Neovim's own vim.lsp.enable().
-- Mason installs the binaries, see mason.lua.
local servers = {
	"astro",
	"cssls",
	"eslint",
	"expert", -- Elixir / Phoenix (elixir, eelixir, heex)
	"html",
	"jsonls",
	"lua_ls",
	"svelte",
	"tailwindcss",
	"ts_ls",
}

-- Completion is built in: vim.lsp.completion asks the server as you type and,
-- when you accept an item, expands snippets and applies auto-imports.
-- See lua/completion.lua for the keys.
local function enable_completion(client, bufnr)
	if not client:supports_method("textDocument/completion") then
		return
	end
	-- By default the menu only opens on the server's trigger characters
	-- (like `.`); add letters and digits so it opens on every keystroke.
	local provider = client.server_capabilities.completionProvider
	local chars = vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_", "")
	provider.triggerCharacters = vim.list_extend(provider.triggerCharacters or {}, chars)
	vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
	-- The LSP menu replaces 'autocomplete' (buffer words) in this buffer.
	vim.bo[bufnr].autocomplete = false
end

return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Make lua_ls aware of the Neovim runtime, so `vim.*` is known.
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP keymaps and completion",
			callback = function(event)
				local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
				end

				-- Built in since Nvim 0.11/0.12: K hover, grn rename, gra code action,
				-- grr references, gri implementation, grt type definition,
				-- gO document symbols, <C-s> (insert) signature help.
				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("<F2>", vim.lsp.buf.rename, "Rename")
				map("<F4>", vim.lsp.buf.code_action, "Code action")

				enable_completion(client, event.buf)

				-- Fix ESLint problems on save.
				if client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = event.buf,
						command = "LspEslintFixAll",
					})
				end
			end,
		})

		vim.lsp.enable(servers)
	end,
}
