-- the console version of scripthub
-- commands:
-- sh--require *here name of script*
-- sh--list *list* - list of 5 scripts

shcmd = shcmd or {}

function shcmd.print(str)
	print("[SCRIPTHUB] " .. str)
end


function shcmd.initCommands()
	concommand.Add("sh--help", function(ply,cmd,args,argsStr)
		local help = {
			"sh--help - Show this command list.",
			"sh--require (name) - Start script from hub.",
			"sh--list - Show list of scripts. 5 max"
		}

		for _,v in pairs(help) do shcmd.print(v) end
	end)
end

function shcmd.init()
	shcmd.print("ScriptHub loading..")
	shcmd.print("Loading commands")
	shcmd.initCommands()
end


shcmd.init()