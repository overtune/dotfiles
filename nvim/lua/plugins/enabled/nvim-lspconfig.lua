-- Language servers. nvim-lspconfig only ships the server definitions
-- (lsp/<name>.lua); starting them uses Neovim's own vim.lsp.enable().
-- Mason installs the binaries, see mason.lua. Completion comes from
-- blink.cmp, which registers its LSP capabilities itself.
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
			desc = "LSP keymaps",
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
