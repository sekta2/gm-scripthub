-- This version of ScriptHub is meant to be run via [lua_run_cl http.fetch("https://raw.githubusercontent.com/sekta2/gm-scripthub/main/portable.lua",function(content) RunString(content) end)]
-- or for [lua_openscript_cl portable.lua] if you have this script on [lua/]


scripthub = {} or scripthub

function scripthub.open()
	scripthub.window = vgui.Create("DFrame")
	scripthub.window:SetSize(500,450)
	scripthub.window:Center()
end

timer.Simple(1, scripthub.open)