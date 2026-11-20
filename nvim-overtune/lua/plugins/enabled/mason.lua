return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"json-lsp",
				"astro-language-server",
				"svelte-language-server",
				"tailwindcss-language-server",
				"typescript-language-server",
				-- Formatters / linters
				"stylua",
				"prettier",
				"prettierd",
				"biome",
			},
			run_on_start = true,
		},
	},
}
