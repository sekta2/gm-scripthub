-- This version of ScriptHub is meant to be run via [lua_run_cl http.Fetch("https://raw.githubusercontent.com/sekta2/gm-scripthub/main/portable.lua",function(content) RunString(content) end)]
-- or for [lua_openscript_cl portable.lua] if you have this script on [lua/]


scripthub = {} or scripthub

function scripthub.open()
	scripthub.window = vgui.Create("DFrame")
	scripthub.window:SetSize(700,500)
	scripthub.window:Center()
	local del = 700/3

	local but = vgui.Create("DButton",scripthub.window)
	but:SetSize(del,25)
	but:SetPos(del,25)
	but:SetTextColor(Color(255,255,255,255))
	but:SetText("Hub")

	local but = vgui.Create("DButton",scripthub.window)
	but:SetSize(del,25)
	but:SetPos(del*2,25)
	but:SetTextColor(Color(255,255,255,255))
	but:SetText("Hub")

	local but = vgui.Create("DButton",scripthub.window)
	but:SetSize(del,25)
	but:SetPos(del*3,25)
	but:SetTextColor(Color(255,255,255,255))
	but:SetText("Hub")
end

timer.Simple(1, scripthub.open)