-- This version of ScriptHub is meant to be run via [lua_run_cl http.Fetch("https://raw.githubusercontent.com/sekta2/gm-scripthub/main/portable.lua",function(content) RunString(content) end)]
-- or for [lua_openscript_cl portable.lua] if you have this script on [lua/]


scripthub = {} or scripthub

function scripthub.createButton(text,x,y,w,h,parent,doclick1)
	local but = vgui.Create("DButton",parent)
	but:SetSize(w,h)
	but:SetPos(x,y)
	but:SetTextColor(Color(255,255,255,255))
	but:SetText(text)
	but.Paint = function(self,w,h)
		draw.RoundedBox(7, 0, 0, w, h, Color(77,77,77,77))
	end
end

function scripthub.open()
	scripthub.window = vgui.Create("DFrame")
	scripthub.window:SetSize(700,500)
	scripthub.window:Center()
	local del = 700/3

	scripthub.createButton("Hub",0,25,del,25,scripthub.window,function() 

	end)

	scripthub.createButton("Hub",del,25,del,25,scripthub.window,function() 

	end)

	scripthub.createButton("Hub",del*2,25,del,25,scripthub.window,function() 

	end)

end

timer.Simple(1, scripthub.open)