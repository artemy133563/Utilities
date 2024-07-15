getgenv().Config = {
    miscfeatures = false
}

local LOAD_TIME = tick()
local queueonteleport = queue_on_teleport or queueonteleport
local setclipboard = toclipboard or setrbxclipboard or setclipboard
local clonefunction = clonefunc or clonefunction
local hookfunction =
	hookfunc or replacecclosure or detourfunction or replacefunc or replacefunction or replaceclosure or detour_function or
		hookfunction
local setthreadidentity = set_thread_identity or setthreadcaps or setthreadidentity
local firetouchinterests = fire_touch_interests or firetouchinterests
local getnamecallmethod = get_namecall_method or getnamecallmethod
local setnamecallmethod = set_namecall_method or setnamecallmethod
local restorefunction = restorefunction or restoreclosure or restorefunc

local function NotifyP()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Product!";
		Duration = 10; 
		Button1 = "Fired";
		Text = ""
	
	})
end



local a = Instance.new("Part")
for b, c in pairs(getreg()) do
	if type(c) == "table" and #c then
		if rawget(c, "__mode") == "kvs" then
			for d, e in pairs(c) do
				if e == a then
					getgenv().InstanceList = c;
					break
				end
			end
		end
	end
end
local f = {}
function f.invalidate(g)
	if not InstanceList then
		return
	end
	for b, c in pairs(InstanceList) do
		if c == g then
			InstanceList[b] = nil;
			return g
		end
	end
end
if not cloneref then
	getgenv().cloneref = f.invalidate
end

getrenv().Visit = cloneref(game:GetService("Visit"))
getrenv().MarketplaceService = cloneref(game:GetService("MarketplaceService")) -- // theres a reason why thats referenced in the roblox environment
getrenv().HttpRbxApiService = cloneref(game:GetService("HttpRbxApiService"))
getrenv().HttpService = cloneref(game:GetService("HttpService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local ContentProvider = cloneref(game:GetService("ContentProvider"))
local RunService = cloneref(game:GetService("RunService"))
local Stats = cloneref(game:GetService("Stats"))
local Players = cloneref(game:GetService("Players"))
local NetworkClient = cloneref(game:GetService("NetworkClient"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local ProximityPromptService = cloneref(game:GetService("ProximityPromptService"))
local Lighting = cloneref(game:GetService("Lighting"))
local AssetService = cloneref(game:GetService("AssetService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local NetworkSettings = settings().Network
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local loopActive = false
getrenv().getgenv = clonefunction(getgenv)

getgenv().stealth_call = function(script)
	getrenv()._set = clonefunction(setthreadidentity)
	local old
	old = hookmetamethod(game, "__index", function(a, b)
		task.spawn(function()
			_set(7)
			task.wait(0.1)
			local went, error = pcall(function()
				loadstring(script)()
			end)
			print(went, error)
			if went then
				local check = Instance.new("LocalScript")
				check.Parent = Visit
			end
		end)
		hookmetamethod(game, "__index", old)
		return old(a, b)
	end)
end

local function touch(x)
	x = x:FindFirstAncestorWhichIsA("Part")
	if x then
		if firetouchinterest then
			task.spawn(function()
				firetouchinterest(x, Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 1)
				wait()
				firetouchinterest(x, Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 0)
			end)
		end
		x.CFrame = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
	end
end

for i, v in pairs(game.RobloxReplicatedStorage:GetDescendants()) do
	pcall(function()
		v:Destroy()
	end)
end

local function NotifyOk(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = text;
        Duration = 10; 
        Button1 = "Success!";
    
        Text = ""
    
    })
end


task.spawn(function()	
	local discord = loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/main/Menu",true))()
	local win = discord:Window("Connect Hub     | Ugc Sniper")
	local serv = win:Server("UGC Goblin Hub", "http://www.roblox.com/asset/?id=17860774372")
	local main = serv:Channel("Main")
	main:Toggle("Website Sniper", false, function(bool)
		if bool then
			getrenv()._set = clonefunction(setthreadidentity)
			local old
			old = hookmetamethod(game, "__index", function(a, b)
				task.spawn(function()
					_set(7)
					task.wait()
					getgenv().promptpurchaserequestedv2 = MarketplaceService.PromptPurchaseRequestedV2:Connect(
					function(...)
						t = {...}
						local assetId = t[2]
						local idempotencyKey = t[5]
						local purchaseAuthToken = t[6]
						local info = MarketplaceService:GetProductInfo(assetId)
						local productId = info.ProductId
						local price = info.PriceInRobux
						local collectibleItemId = info.CollectibleItemId
						local collectibleProductId = info.CollectibleProductId
						print("IdempotencyKey: " .. idempotencyKey)
						print("CollectibleItemId: " .. collectibleItemId)
						print("CollectibleProductId: " .. collectibleProductId)
						print("PurchaseAuthToken: " .. purchaseAuthToken)
						print("ProductId (SHOULD BE 0): " .. productId)
						print("Price: " .. price)
						warn("FIRST PURCHASE ATTEMPT")
						for i, v in pairs(MarketplaceService:PerformPurchase(Enum.InfoType.Asset, productId, price,
							tostring(game:GetService("HttpService"):GenerateGUID(false)), true, collectibleItemId,
							collectibleProductId, idempotencyKey, tostring(purchaseAuthToken))) do
								tostring(discord:Notification("Prompt Detected", "Result...", "" .. v, i))
						end
					end)
				end)
				hookmetamethod(game, "__index", old)
				return old(a, b)
			end)
		else
			getgenv().promptpurchaserequestedv2:Disconnect()
		end
	end)
	main:Toggle("Auto Cancel Prompt", false, function(bool)
		loopActive = bool
		if loopActive then
			while loopActive == true do
				local purchasePrompt = game.CoreGui:FindFirstChild("PurchasePrompt")
				if purchasePrompt then
					local productPurchaseContainer = purchasePrompt:FindFirstChild("ProductPurchaseContainer")
					if productPurchaseContainer then
						local animator = productPurchaseContainer:FindFirstChild("Animator")
						if animator then
							local prompt = animator:FindFirstChild("Prompt")
							if prompt and 
								prompt:FindFirstChild("AlertContents") and
								prompt.AlertContents:FindFirstChild("Footer") and
								prompt.AlertContents.Footer:FindFirstChild("Buttons") then

								for _, button in ipairs(prompt.AlertContents.Footer.Buttons:GetChildren()) do
									if button:FindFirstChild("ButtonContent") and
										button.ButtonContent:FindFirstChild("ButtonMiddleContent") and
										button.ButtonContent.ButtonMiddleContent:FindFirstChildOfClass("TextLabel") and
										button.ButtonContent.ButtonMiddleContent:FindFirstChildOfClass("TextLabel").Text == "Cancel" then

										local pos = button.AbsolutePosition
										print(pos)

										for _, v in ipairs(prompt.AlertContents.Footer.Buttons:GetChildren()) do
											print(v.Name)
										end

										game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + button.AbsoluteSize.X / 2, pos.Y + button.AbsoluteSize.Y, 0, true, game, 1)
										wait()
										game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + button.AbsoluteSize.X / 2, pos.Y + button.AbsoluteSize.Y, 0, false, game, 1)
									end
								end
							end
						end
					end
				end
				wait(0)
				if loopActive == false then
					break
				end
			end
		end
	end)
	main:Toggle("Auto Close Error", false, function(value)
		loopActive = value
		spawn(function()
			while loopActive do
				local pp = game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt")
				if pp and pp.AlertContents and pp.AlertContents.Footer and pp.AlertContents.Footer.Buttons and not pp.AlertContents.Footer.Buttons:FindFirstChild("2") then
					if pp.AlertContents.Footer.Buttons:FindFirstChild("1") then
						local b1 = pp.AlertContents.Footer.Buttons[1].AbsolutePosition
						game:GetService("VirtualInputManager"):SendMouseButtonEvent(b1.X + 55, b1.Y + 65.5, 0, true, game, 1)
						wait()
						game:GetService("VirtualInputManager"):SendMouseButtonEvent(b1.X + 55, b1.Y + 65.5, 0, false, game, 1)
					end
				end
				task.wait()
			end
		end)
	end)
	main:Button("Anti Afk", function()
		local VirtualUser = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			VirtualUser:CaptureController()VirtualUser:ClickButton2(Vector2.new())
		end)
	end)
	main:Toggle("Auto Hide Other Players", false, function(bool)
		if bool then
			local usernames = {}
			while task.wait(0.1) do
				local players = Players:GetPlayers()
				local localPlayer = Players.LocalPlayer
				local cusernames = {}
				for _, player in ipairs(players) do
					if player ~= localPlayer then
						table.insert(cusernames, player.Name)
						if not usernames[player.Name] then
							usernames[player.Name] = true
						end
					end
				end
				for username, _ in pairs(usernames) do
					if not table.find(cusernames, username) then
						usernames[username] = nil
					end
				end
				local models = game.Workspace:GetChildren()
				for _, model in ipairs(models) do
					if model:IsA("Model") then
						if usernames[model.Name] then
							model:Destroy()
						end
					end
				end
				if Visit:FindFirstChild("Part") then
					break
				end
			end
		else
			local kill = Instance.new("Part")
			kill.Parent = Visit
			task.wait(0.2)
			kill:Destroy()
		end
	end)
local remotes = serv:Channel("Remotes")
remotes:Textbox("UGC Limited Item ID", "Enter Item ID that you wanna be included in the arguments...", false,
	function(t)
		local tt = tonumber(t)
		if type(tt) == "number" then
			getgenv().limitedidforfiringremotewithwyvern = tt
			discord:Notification("Success",
				"The script now remembers that the Item ID you want is " .. tostring(tt) .. "!", "Ok!")
		else
			discord:Notification("Error", "That's... not an Item ID.", "Okay!")
		end
	end)
remotes:Dropdown("Remote Arguments...",
	{"No Arguments/Blank", "LocalPlayer", "Your Username", "UGC Item ID", "UGC Item ID, LocalPlayer",
	 "LocalPlayer, UGC Item ID", "'UGC' as a string", "UGC Item ID, 'true' boolean", "'true' boolean",
	 "literal lua code to prompt item", "loadstring prompt item"}, function(x)
		if not getgenv().limitedidforfiringremotewithwyvern then
			discord:Notification("Error",
				"You must put a Limited Item ID at the first textbox before firing...",
				"Ok!")
		else
			local id = getgenv().limitedidforfiringremotewithwyvern
			local fire = function(args)
				local count = 0
				for i, v in pairs(game:GetDescendants()) do
					if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
						count = count + 1
						task.spawn(function()
							v:FireServer(args)
						end)
					elseif v:IsA("RemoteFunction") then
						count = count + 1
						task.spawn(function()
							v:InvokeServer(args)
						end)
					end
				end
				discord:Notification("Success", "Fired " .. count .. " RemoteEvents and RemoteFunctions!", "Ok!")
			end
			local _fire = function(args, args2)
				local count = 0
				for i, v in pairs(game:GetDescendants()) do
					if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
						count = count + 1
						task.spawn(function()
							v:FireServer(args, args2)
						end)
						pcall(function()
							v:FireServer(args, args2)
						end)
					elseif v:IsA("RemoteFunction") then
						count = count + 1
						task.spawn(function()
							v:InvokeServer(args, args2)
						end)
					end
				end
				discord:Notification("Success", "Fired " .. count .. " RemoteEvents and RemoteFunctions", "Ok!")
			end
			if x == "No Arguments/Blank" then
				fire(" ")
			elseif x == "LocalPlayer" then
				fire(game.Players.LocalPlayer)
			elseif x == "Your Username" then
				fire(tostring(game.Players.LocalPlayer))
			elseif x == "UGC Item ID" then
				fire(id)
			elseif x == "UGC Item ID, LocalPlayer" then
				_fire(id, game.Players.LocalPlayer)
			elseif x == "LocalPlayer, UGC Item ID" then
				_fire(game.Players.LocalPlayer, id)
			elseif x == "'UGC' as a string" then
				fire("UGC")
			elseif x == "UGC Item ID, 'true' boolean" then
				_fire(id, true)
			elseif x == "'true' boolean" then
				fire(true)
			elseif x == "literal lua code to prompt item" then
				fire('game:GetService("MarketplaceService"):PromptPurchase(game.Players.' ..
						 tostring(game.Players.LocalPlayer) .. ', ' .. tostring(id) .. ')')
			elseif x == "loadstring prompt item" then
				fire('loadstring(`game:GetService("MarketplaceService"):PromptPurchase(game.Players.' ..
						 tostring(game.Players.LocalPlayer) .. ', ' .. tostring(id) .. ')`)()')
			end
		end
	end)
remotes:Toggle("Block All RemoteEvents and RemoteFunctions", false, function(bool)
	if bool then
		local Methods = {"FireServer", "fireserver", "InvokeServer", "invokeserver", "Fire", "fire", "Invoke",
						 "invoke"}

		getgenv().Toggleblock = true
		local OldNameCall = nil
		OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(...)
			local Self = ...
			if table.find(Methods, getnamecallmethod()) then
				if Toggle and Self then
					return
				end
			end
			return OldNameCall(...)
		end))
	else
		getgenv().Toggleblock = false
	end
end)
remotes:Seperator()
remotes:Button("Print All Remotes (Includes Path)", function()
	for i, v in pairs(game:GetDescendants()) do
		if v:IsA("RemoteEvent") then
			print("RemoteEvent: " .. v:GetFullName())
		elseif v:IsA("RemoteFunction") then
			print("RemoteFunction: " .. v:GetFullName())
		elseif v:IsA("UnreliableRemoteEvent") then
			print("UnreliableRemoteEvent: " .. v:GetFullName())
		end
	end
	discord:Notification("Success", "Check console by clicking F9 or typing '/console' in the chat.", "Ok!")
	local input = loadstring(game:HttpGet('https://pastebin.com/raw/dYzQv3d8'))()
	input.press(Enum.KeyCode.F9)
end)
local games = serv:Channel("Games")
local antikickonteleport = false
games:Toggle("Inject Anti Kick on Teleport", false, function(bool)
	if bool then
		antikickonteleport = true
	else
		antikickonteleport = false
	end
end)
games:Textbox("Pause gameplay for a specified amount of time.",
	"How long do you want to pause the game for? (In seconds)", true, function(t)
		local tt = tonumber(t)
		if type(tt) == "number" then
			Players.LocalPlayer.GameplayPaused = true
			task.wait()
			Players.LocalPlayer.GameplayPaused = false
			task.wait()
			Players.LocalPlayer.GameplayPaused = true
			task.wait(tt)
			Players.LocalPlayer.GameplayPaused = false
		else
			discord:Notification("Error", "You must enter a number. (In seconds)", "Ok!")
		end
	end)
games:Toggle("Force Full Bright Lighting", false, function()
	Lighting.Brightness = 2
	Lighting.ClockTime = 14
	Lighting.FogEnd = 100000
	Lighting.GlobalShadows = false
	Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
games:Button("Teleport to Smallest Server", function()
	local gameapi = "https://games.roblox.com/v1/games/"
	local _place = game.PlaceId
	local _servers = gameapi .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
	function ListServers(cursor)
		local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
		return HttpService:JSONDecode(Raw)
	end
	local Server, Next;
	repeat
		local Servers = ListServers(Next)
		Server = Servers.data[1]
		Next = Servers.nextPageCursor
	until Server
	discord:Notification("Teleporting", "Teleporting to...\n" .. game.PlaceId .. "\nJob ID: " .. Server.id, "Ok!")
	if antikickonteleport then
		pcall(function()
			queueonteleport(
				'local kick; kick = hookmetamethod(game, "__namecall", function(obj, ...) local args = {...} local method = getnamecallmethod() if method == "Kick" then if args[1] then print("...") end return nil end return kick(obj, unpack(args)) end)')
		end)
		TeleportService:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
	end
end)
games:Button("Force Close Roblox App", function()
	game:Shutdown()
end)
games:Label("Current Game's Place ID:\n" .. game.PlaceId)
games:Label("Current Game's Universe ID:\n" .. game.GameId)
games:Label("Current Game's Job ID: \n" .. game.JobId)
local purchase = serv:Channel("Purchase Exploits")
local x_x = HttpService:JSONDecode(game:HttpGet(
	"https://apis.roblox.com/developer-products/v1/developer-products/list?universeId=" .. game.GameId .. "&page=1"))
local dnames = {}
local dproductIds = {}
if type(x_x.DeveloperProducts) == "nil" then
	table.insert(dnames, " ")
end

pcall(function()

	local currentPage = 1

	repeat
		local response = game:HttpGet(
			"https://apis.roblox.com/developer-products/v1/developer-products/list?universeId=" ..
				tostring(game.GameId) .. "&page=" .. tostring(currentPage))
		local decodedResponse = HttpService:JSONDecode(response)
		local developerProducts = decodedResponse.DeveloperProducts
		print("Page " .. currentPage .. ":")
		for _, developerProduct in pairs(developerProducts) do
			table.insert(dnames, developerProduct.Name)
			table.insert(dproductIds, developerProduct.ProductId)
		end
		currentPage = currentPage + 1
		local final = decodedResponse.FinalPage
	until final
end)

purchase:Dropdown("Select DevProduct", dnames, function(x)
	index = nil
	for i, name in ipairs(dnames) do
		if name == x then
			index = i
			break
		end
	end
end)
purchase:Button("Fire Selected Dev Product!", function()
	if index then
		local product = dproductIds[index]
		pcall(function()
			stealth_call(
				'MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' ..
					product .. ', true) ')
		end)
		task.wait(0.2)
		if not Visit:FindFirstChild("LocalScript") then
			discord:Notification("Error", "Your executor blocked function SignalPromptProductPurchaseFinished.", 
				"Ok!")
		else
			NotifyP()
			Visit:FindFirstChild("LocalScript"):Destroy()
		end
	else
		discord:Notification("Error", "Something went wrong but I don't know what.", "Ok!")
	end
end)
purchase:Button("Fire All Dev Products", function()
	getrenv()._set = clonefunction(setthreadidentity)
	for i, product in pairs(dproductIds) do
		task.spawn(function()
			pcall(function()
				stealth_call(
					'MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' ..
						product .. ', true) ')
			end)
		end)
		task.wait()
	end
	NotifyP()
end)
purchase:Toggle("Loop Selected Dev Product", false, function(state)
	Config.miscfeatures = state
	while true do
		if not Config.miscfeatures then return end
		local product = dproductIds[index]
		pcall(function()
			stealth_call('MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' ..product .. ', true) ')
		end)
		task.wait()
	end
end)
purchase:Toggle("Loop All Dev Products", false, function(state)
	task.spawn(function()
		Config.miscfeatures = state
		while true do
			if not Config.miscfeatures then return end

			for i, product in pairs(dproductIds) do
				stealth_call('MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, ' ..product .. ', true) ')
			end
			task.wait(2)
		end
	end)
end)
local wyverngamepass = game.HttpService:JSONDecode(game:HttpGet(
	"https://games.roblox.com/v1/games/" .. game.GameId .. "/game-passes?limit=100&sortOrder=1"))
local gnames = {}
local gproductIds = {}
for i, v in pairs(wyverngamepass.data) do
	table.insert(gnames, v.name)
	table.insert(gproductIds, v.id)
end
local gamepass
purchase:Dropdown("GamePass Purchase", gnames, function(x)
	for i, name in ipairs(gnames) do
		if name == x then
			gamepass = gproductIds[i]
			break
		end
	end
end)
purchase:Button("Fire Selected Gamepass", function()
	if gamepass then
		pcall(function()
			stealth_call('MarketplaceService:SignalPromptGamePassPurchaseFinished(game.Players.LocalPlayer, ' ..
							 tostring(gamepass) .. ', true)')
		end)
		task.wait(0.2)
		if not Visit:FindFirstChild("LocalScript") then
			discord:Notification("Error", "Your executor blocked function SignalPromptGamePassPurchaseFinished.",
				"Ok!")
		else
			NotifyP()
			Visit:FindFirstChild("LocalScript"):Destroy()
		end
	else
		discord:Notification("Error", "Something went wrong but I don't know what.", "Ok!")
	end
end)
end)
