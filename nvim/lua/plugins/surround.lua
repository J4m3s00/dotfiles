-- For surrounding strings
return {
	"nvim-mini/mini.surround",
	config = function(_, ops)
		require("mini.surround").setup(ops)
	end,
}
