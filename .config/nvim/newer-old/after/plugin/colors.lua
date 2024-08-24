
function setColor(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)
end

setColor()
