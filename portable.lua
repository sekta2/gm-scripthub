-- This version of ScriptHub is meant to be run via [lua_run_cl http.Fetch("https://raw.githubusercontent.com/sekta2/gm-scripthub/main/portable.lua",function(content) RunString(content) end)]
-- or for [lua_openscript_cl portable.lua] if you have this script on [lua/]


scripthub = {} or scripthub
scripthub.scripts = "https://raw.githubusercontent.com/sekta2/gm-scripthub/main/scripts/tree.json"
scripthub.tbl = nil
http.Fetch(scripthub.scripts, function(jsoncontent)
	scripthub.tbl = util.JSONToTable(jsoncontent)
end)

function scripthub.createButton(text,x,y,w,h,parent,doclick1)
	local but = vgui.Create("DButton",parent)
	but:SetSize(w,h)
	but:SetPos(x,y)
	but:SetTextColor(Color(45,135,240,255))
	but:SetText(text)
	but.Paint = function(self,w,h)
		surface.SetDrawColor(Color(45,135,240,255))
		surface.DrawOutlinedRect( 1, 1, w-2, h-2, 2 )
	end
	but.DoClick = function() doclick1() end
end

function scripthub.open()
	scripthub.window = vgui.Create("DFrame")
	scripthub.window:SetSize(700,500)
	scripthub.window:Center()
	scripthub.window:SetDraggable(false)
	scripthub.window:ShowCloseButton(true)
	scripthub.window.Paint = function(self,w,h)
		draw.RoundedBox(7, 0, 0, w, h, Color(255,255,255,255))
	end
	scripthub.window.hide = false
	local del = 700/3

	local function scriptsShow()
		if IsValid(scripthub.window.panel) then scripthub.window.panel:Remove() end
		scripthub.window.panel = vgui.Create("DPanel",scripthub.window)
		scripthub.window.panel:SetPos(50,55)
		scripthub.window.panel:SetSize(700-(50*2),500-(55*2))
	end


	scripthub.createButton("Show/Hide",700/2-del/2,0,del,25,scripthub.window,function() 
		if scripthub.window.hide then
			scripthub.window.hide = false
			scripthub.window:MoveTo(ScrW()/2-700/2, ScrH()/2-500/2, 0.3, 0, 0.3, function() end)
		else
			scripthub.window.hide = true
			scripthub.window:MoveTo(ScrW()/2-700/2, ScrH()-25, 0.3, 0, 0.3, function() end)
		end
	end)

	scripthub.window.panel = vgui.Create("DPropertySheet",scripthub.window)
	scripthub.window.panel:SetSize(700-10,400-25)
	scripthub.window.panel:SetPos(5,25)
	scripthub.window.panel:Dock( FILL )

	scripthub.window.panel.scripts = vgui.Create("DPanel")
	scripthub.window.panel:AddSheet("Hub", scripthub.window.panel.scripts, "icon16/table.png")

	scripthub.window.panel.scripts = vgui.Create("DPanel")
	local w = scripthub.window.panel.scripts:GetWide()
	local h = scripthub.window.panel.scripts:GetTall()
	print(w)
	print(h)

	local textentry = vgui.Create("DTextEntry",scripthub.window.panel.scripts)
	textentry:SetSize(700,500)
	textentry:SetContentAlignment("bottom-left")

	scripthub.createButton("Run",0,h-25,w,25,scripthub.window.panel.scripts,function()
		RunString(textentry:GetValue())
	end)

	scripthub.window.panel:AddSheet("Lua run", scripthub.window.panel.scripts, "icon16/script_code.png")

end

timer.Simple(1, scripthub.open)