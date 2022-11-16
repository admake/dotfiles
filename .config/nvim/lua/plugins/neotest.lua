-- Test Runner
require("neotest").setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "npm test --",
			cwd = function(path)
				return vim.fn.getcwd()
			end,
		}),
	},
})
