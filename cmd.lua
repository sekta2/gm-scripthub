-- the console version of scripthub
-- commands:
-- sh--require *here name of script*
-- sh--list *list* - list of 5 scripts

shcmd = shcmd or {}
shcmd.scripts = {}

function shcmd.print(str)
	MsgC(Color(45,136,240),"[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end

function shcmd.printError(str)
	MsgC(Color(229,50,50),"[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end

function shcmd.printSuccess(str)
	MsgC(Color(50,229,50),"[SCRIPTHUB] ",Color(255,255,255),str,"\n")
end

local function loadFromPastebin()
	http.Fetch("https://pastebin.com/raw/dmLKiEq2", 
	function(jsont)
		shcmd.scripts = util.JSONToTable(jsont)
		shcmd.printSuccess("Successfully loaded scripts from pastebin!")
	end, 
	function(errorStr) 
		shcmd.printError("Fail to load scripts from pastebin: "..errorStr)
	end)
end

http.Fetch("https://raw.githubusercontent.com/sekta2/gm-scripthub/main/scripts/tree.json", 
function(jsont)
	shcmd.scripts = util.JSONToTable(jsont)
	shcmd.printSuccess("Successfully loaded scripts from github!")
end, 
function(errorStr) 
	shcmd.printError("Fail to load scripts from github: "..errorStr)
	shcmd.printError("Trying get scripts from pastebin..")
	loadFromPastebin()
end)


function shcmd.initCommands()
	concommand.Add("sh--help", function(ply,cmd,args,argsStr)
		local help = {
			"sh--help - Show this command list.",
			"sh--require (name) - Run script from hub.",
			"sh--list - Show list of scripts. 5 max"
		}

		for _,v in pairs(help) do shcmd.print(v) end
	end)

	concommand.Add("sh--require", function(ply,cmd,args,argsStr)
		local find = false
		for k,v in pairs(shcmd.scripts) do
			print(k)
			print(args[1])
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
		local find = false
		for k,v in pairs(shcmd.scripts) do
			shcmd.print("  ")
			shcmd.print("ID: "..k)
			shcmd.print("Name: "..v["name"])
			shcmd.print("Description: "..v["desc"])
			shcmd.print("Author: "..v["author"])
			shcmd.print("Run-Command: ".."sh--require "..k)
		end
	end)
end

function shcmd.init()
	shcmd.print("ScriptHub loading..")
	shcmd.print("Loading commands")
	shcmd.initCommands()
end


shcmd.init()