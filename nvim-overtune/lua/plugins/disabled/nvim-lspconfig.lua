return {
	"neovim/nvim-lspconfig",
	event = "VimEnter",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"ibhagwan/fzf-lua",
		"b0o/schemastore.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup()

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			-- Default handler for all servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- Disable rust_analyzer (handled elsewhere, e.g., by rustaceanvim)
			["rust_analyzer"] = function() end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									vim.env.VIMRUNTIME,
								},
							},
						},
					},
				})
			end,

			["jsonls"] = function()
				lspconfig.jsonls.setup({
					capabilities = capabilities,
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
						},
					},
					setup = {
						commands = {
							Format = {
								function()
									vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
								end,
							},
						},
					},
				})
			end,

			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					settings = {
						-- TypeScript server settings if needed
					},
				})
			end,

			["svelte"] = function()
				lspconfig.svelte.setup({
					capabilities = capabilities,
				})
			end,

			["tailwindcss"] = function()
				lspconfig.tailwindcss.setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
						"vue",
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = { { "tv\\(([^;]*)\\);", "'([^']*)'" } },
							},
							includeLanguages = {
								svelte = "html",
							},
							lint = {
								cssConflict = "warning",
								invalidApply = "error",
								invalidConfigPath = "error",
								invalidScreen = "error",
								invalidTailwindDirective = "error",
								invalidVariant = "error",
								recommendedVariantOrder = "warning",
							},
							validate = true,
						},
					},
				})
			end,
		})

		-- UI configuration
		require("lspconfig.ui.windows").default_options.border = "single"
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})
		vim.diagnostic.config({
			float = { border = "single" },
		})

		-- Custom commands
		vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
			local current_value = vim.diagnostic.config().virtual_text
			vim.diagnostic.config({ virtual_text = not current_value })
		end, {})

		vim.api.nvim_create_user_command("DiagnosticsToggle", function()
			local current_value = vim.diagnostic.is_enabled()
			vim.diagnostic.enable(not current_value)
		end, {})
	end,
	keys = {
		{ "K",           ":lua vim.lsp.buf.hover()<CR>",          desc = "LSP Hover" },
		{ "gD",          ":lua vim.lsp.buf.declaration()<CR>",    desc = "LSP goto declaration" },
		{ "gd",          ":FzfLua lsp_definitions<cr>",           desc = "LSP goto definition" },
		{ "gr",          ":FzfLua lsp_references<cr>",            desc = "LSP goto references" },
		{ "gi",          ":FzfLua lsp_implementations<cr>",       desc = "LSP goto implementations" },
		{ "go",          ":FzfLua lsp_document_symbols<CR>",      desc = "LSP find document symbols" },
		{ "gO",          ":FzfLua lsp_workspace_symbols<CR>",     desc = "LSP find workspace symbols" },
		{ "g[",          ":lua vim.diagnostic.goto_prev()<CR>",   desc = "goto prev diagnostic" },
		{ "g]",          ":lua vim.diagnostic.goto_next()<CR>",   desc = "goto next diagnostic" },
		{ "<leader>li",  ":LspInfo<CR>",                          desc = "LSP information" },
		{ "<leader>lr",  ":lua vim.lsp.buf.rename()<CR>",         desc = "LSP symbol rename" },
		{ "<leader>ls",  ":lua vim.lsp.buf.signature_help()<CR>", desc = "LSP signature help" },
		{ "<leader>lk",  ":lua vim.lsp.buf.signature_help()<CR>", desc = "LSP signature help" },
		{ "<leader>ld",  ":lua vim.diagnostic.open_float()<CR>",  desc = "LSP line diagnostics" },
		{ "<leader>lD",  ":FzfLua diagnostics_workspace<CR>",     desc = "LSP Workspace diagnostics" },
		{ "<leader>lq",  ":lua vim.diagnostic.setloclist()<CR>",  desc = "Quickfix diagnostics" },
		{ "<leader>la",  ":FzfLua lsp_code_actions<CR>",          desc = "LSP code actions" },
		{ "<leader>ltl", ":DiagnosticsToggleVirtualText<CR>",     desc = "LSP toggle inline diagnostics" },
		{ "<leader>ltd", ":DiagnosticsToggle<CR>",                desc = "LSP toggle diagnostics" },
		{
			"<leader>lf",
			":lua vim.lsp.buf.format()<CR>",
			desc = "LSP format",
			mode = { "n" },
		},
		{
			"<leader>lf",
			function()
				vim.lsp.buf.format({ async = false })
			end,
			desc = "LSP format selection",
			mode = { "v", "x" },
		},
	},
}
