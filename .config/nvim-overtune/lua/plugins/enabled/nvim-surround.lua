return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			surrounds = {
				-- Markdown bold: S* in visual mode, ysiw* on a word
				["*"] = {
					add = { "**", "**" },
					find = "%*%*.-%*%*",
					delete = "^(%*%*)().-(%*%*)()$",
				},
			},
		},
	},
}
