return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Installs the parsers (asynchronously, no-op if already installed)
			require("nvim-treesitter").install({
				"elixir",
				"eex",
				"heex",
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"svelte",
			})

			-- The main branch does not enable highlighting or indentation automatically
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
