-- the console version of scripthub
-- commands:
-- sh--require *here name of script*
-- sh--list *list* - list of 5 scripts

shcmd = shcmd or {}
shcmd.scripts = {}

function shcmd.print(str)
	local time = os.date("*t")
	MsgC(Color(45,136,240),"[",time.hour,":",time.min,":",time.sec,"]","[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end

function shcmd.printError(str)
	local time = os.date("*t")
	MsgC(Color(229,50,50),"[",time.hour,":",time.min,":",time.sec,"]","[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end

function shcmd.printSuccess(str)
	local time = os.date("*t")
	MsgC(Color(50,229,50),"[",time.hour,":",time.min,":",time.sec,"]","[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end


function shcmd.loadScripts()
	http.Fetch("https://gm-scripthub.000webhostapp.com/getscripts.php", 
	function(jsont)
		shcmd.scripts = util.JSONToTable(jsont)
		shcmd.printSuccess("Successfully loaded scripts from server!")
	end, 
	function(errorStr) 
		shcmd.printError("Fail to load scripts from server: "..errorStr)
	end)
end


function shcmd.initCommands()
	concommand.Add("sh--help", function(ply,cmd,args,argsStr)
		local help = {
			"sh--help - Show this command list.",
			"sh--require (name) - Run script from hub.",
			"sh--list - Show list of scripts. 5 max",
			"sh--load - Load scripts again",
			"sh--upload - Upload script to server(scripthub db)"
		}

		for _,v in pairs(help) do shcmd.print(v) end
	end)

	concommand.Add("sh--require", function(ply,cmd,args,argsStr)
		local find = false
		for k,v in pairs(shcmd.scripts) do
			if k==args[1] then
				find=true
				http.Fetch(v["file"],function(content)
					RunString(content)
					shcmd.print("Running script '" .. args[1] .. "'...")
				end, function(errorStr) shcmd.printError("Failed to get script code") end)
			end
		end
		if find==false then shcmd.printError("Script not found! :(") end
	end)

	concommand.Add("sh--list", function(ply,cmd,args,argsStr)
		local id = 1
		for k,v in pairs(shcmd.scripts) do
			shcmd.print(" ")
			shcmd.print(id)
			shcmd.print("ID: "..k)
			shcmd.print("Name: "..v["name"])
			shcmd.print("Description: "..v["desc"])
			shcmd.print("Author: "..v["author"])
			shcmd.print("Run-Command: ".."sh--require "..k)
			id = id+1
		end
	end)

	concommand.Add("sh--load", function(ply,cmd,args,argsStr)
		shcmd.loadScripts()
	end)

	concommand.Add("sh--upload", function(ply,cmd,args,argsStr)
		gui.OpenURL("https://gm-scripthub.000webhostapp.com/")
	end)
end

function shcmd.init()
	shcmd.print("ScriptHub loading..")
	shcmd.print("Loading commands")
	shcmd.initCommands()
	shcmd.print("Loading scripts")
	shcmd.loadScripts()
end


shcmd.init()