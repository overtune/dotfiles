-- Mason installs language servers and formatters into Neovim's data dir.
-- mason-tool-installer installs everything below on startup, so a new
-- machine needs no manual steps. Update with :MasonToolsUpdate.
return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Language servers (enabled in nvim-lspconfig.lua)
				"astro-language-server",
				"css-lsp",
				"eslint-lsp",
				"expert",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"svelte-language-server",
				"tailwindcss-language-server",
				"typescript-language-server",
				-- Formatters (used by conform.lua)
				"biome",
				"prettier",
				"prettierd",
				"stylua",
			},
			run_on_start = true,
		},
	},
}
