local function js_formatters(bufnr)
	local biome_config = vim.fs.find(
		{ "biome.json", "biome.jsonc" },
		{ path = vim.api.nvim_buf_get_name(bufnr), upward = true, type = "file" }
	)
	if #biome_config > 0 then
		return { "biome" }
	end
	return { "prettierd", "prettier", stop_after_first = true }
end

local function markup_formatters()
	return { "prettierd", "prettier", stop_after_first = true }
end

return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = js_formatters,
				typescript = js_formatters,
				javascriptreact = js_formatters,
				typescriptreact = js_formatters,
				json = js_formatters,
				jsonc = js_formatters,
				css = js_formatters,
				svelte = markup_formatters,
				astro = markup_formatters,
				html = markup_formatters,
				markdown = markup_formatters,
				yaml = markup_formatters,
			},
		},
	},
}
