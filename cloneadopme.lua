local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local FurnitureRegistry = require(RS:WaitForChild("SharedModules"):WaitForChild("Game"):WaitForChild("FurnitureSelectorHelpers"):WaitForChild("FurnitureRegistry"))

local LP = Players.LocalPlayer
local API = RS.API

local savedHouses = {}
local playerNamePattern = LP.Name:gsub("%W", "")

local hideUsername = false
local hideHouseInfo = false

local function createInstance(className, properties, parent)
	local instance = Instance.new(className)
	for k, v in pairs(properties) do
		instance[k] = v
	end
	if parent then
		instance.Parent = parent
	end
	return instance
end

local function createFrame(properties, parent)
	local frame = createInstance("Frame", properties, parent)
	createInstance("UICorner", {CornerRadius = UDim.new(0, 8)}, frame)
	return frame
end

local function createButton(properties, parent)
	local button = createInstance("TextButton", properties, parent)
	createInstance("UICorner", {CornerRadius = UDim.new(0, 8)}, button)
	return button
end

local function createCard(size, position, color, parent)
	return createFrame({
		Size = size,
		Position = position or UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = color or Color3.fromRGB(45, 45, 50),
		BorderSizePixel = 0
	}, parent)
end

local function processRawColors(raw)
    if not raw or type(raw) ~= "table" then
        return {}
    end
    
    local processed = {}
    
    local hasColor3 = false
    for _, v in pairs(raw) do
        if typeof(v) == "Color3" then
            hasColor3 = true
            break
        end
    end
    
    if hasColor3 then
        return raw
    end
    
    local values = {}
    for _, v in pairs(raw) do
        if type(v) == "number" then
            table.insert(values, v)
        elseif type(v) == "table" and #v == 3 then
            local index = #processed + 1
            processed[index] = Color3.new(unpack(v))
        end
    end
    
    for i = 1, #values, 3 do
        if values[i] and values[i+1] and values[i+2] then
            local index = #processed + 1
            processed[index] = Color3.new(values[i], values[i+1], values[i+2])
        end
    end
    
    return processed
end

local gui = createInstance("ScreenGui", {
	Name = "HouseCloner",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})
if syn and syn.protect_gui then
	syn.protect_gui(gui)
	gui.Parent = CoreGui
elseif gethui then
	gui.Parent = gethui()
else
	gui.Parent = CoreGui
end

local mainFrame = createFrame({
	Name = "MainFrame",
	Size = UDim2.new(0, 400, 0, 500),
	Position = UDim2.new(1, -420, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	BackgroundColor3 = Color3.fromRGB(30, 30, 35),
	BorderSizePixel = 0,
	ClipsDescendants = true
}, gui)

local shadow = createInstance("ImageLabel", {
	Name = "Shadow",
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(1, 30, 1, 30),
	ZIndex = -1,
	Image = "rbxassetid://6014261993",
	ImageColor3 = Color3.fromRGB(0, 0, 0),
	ImageTransparency = 0.5,
	ScaleType = Enum.ScaleType.Slice,
	SliceCenter = Rect.new(49, 49, 450, 450)
}, mainFrame)

local header = createFrame({
	Name = "Header",
	Size = UDim2.new(1, 0, 0, 50),
	BackgroundColor3 = Color3.fromRGB(40, 40, 45),
	BorderSizePixel = 0
}, mainFrame)

createInstance("Frame", {
	Name = "HeaderFix",
	Size = UDim2.new(1, 0, 0, 10),
	Position = UDim2.new(0, 0, 1, -10),
	BackgroundColor3 = Color3.fromRGB(40, 40, 45),
	BorderSizePixel = 0,
	ZIndex = 2
}, header)

createInstance("TextLabel", {
	Name = "Title",
	Size = UDim2.new(1, -20, 1, 0),
	Position = UDim2.new(0, 20, 0, 0),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 22,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "House Cloner"
}, header)

local closeButton = createInstance("TextButton", {
	Name = "CloseButton",
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(1, -40, 0, 10),
	BackgroundColor3 = Color3.fromRGB(255, 80, 80),
	Text = ""
}, header)
createInstance("UICorner", {CornerRadius = UDim.new(0, 15)}, closeButton)

local minimizeButton = createInstance("TextButton", {
	Name = "MinimizeButton",
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(1, -80, 0, 10),
	BackgroundColor3 = Color3.fromRGB(255, 200, 50),
	Text = ""
}, header)
createInstance("UICorner", {CornerRadius = UDim.new(0, 15)}, minimizeButton)

local tabsContainer = createInstance("Frame", {
	Name = "TabsContainer",
	Size = UDim2.new(1, 0, 0, 40),
	Position = UDim2.new(0, 0, 0, 50),
	BackgroundColor3 = Color3.fromRGB(35, 35, 40),
	BorderSizePixel = 0
}, mainFrame)

createInstance("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Left,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 0)
}, tabsContainer)

local housesTab = createInstance("TextButton", {
	Name = "HousesTab",
	Size = UDim2.new(0.5, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(60, 120, 190),
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 16,
	Text = "HOUSES"
}, tabsContainer)

local infoTab = createInstance("TextButton", {
	Name = "InfoTab",
	Size = UDim2.new(0.5, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(35, 35, 40),
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(180, 180, 180),
	TextSize = 16,
	Text = "INFO"
}, tabsContainer)

local contentContainer = createInstance("Frame", {
	Name = "ContentContainer",
	Size = UDim2.new(1, 0, 1, -90),
	Position = UDim2.new(0, 0, 0, 90),
	BackgroundTransparency = 1
}, mainFrame)

local housesContent = createInstance("Frame", {
	Name = "HousesContent",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Visible = true
}, contentContainer)

local infoContent = createInstance("Frame", {
	Name = "InfoContent",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Visible = false
}, contentContainer)

local statsContainer = createCard(UDim2.new(1, -40, 0, 80), UDim2.new(0, 20, 0, 0), Color3.fromRGB(45, 45, 50), housesContent)
local statsLayout = createInstance("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 20)
}, statsContainer)

local housesCount = createInstance("Frame", {
	Name = "HousesCount",
	Size = UDim2.new(0, 100, 0, 60),
	BackgroundTransparency = 1
}, statsContainer)

local countValue = createInstance("TextLabel", {
	Name = "CountValue",
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 24,
	Text = "0"
}, housesCount)

createInstance("TextLabel", {
	Name = "CountLabel",
	Size = UDim2.new(1, 0, 0, 20),
	Position = UDim2.new(0, 0, 1, -20),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 14,
	Text = "Houses Saved"
}, housesCount)

local playerInfo = createInstance("Frame", {
	Name = "PlayerInfo",
	Size = UDim2.new(0, 150, 0, 60),
	BackgroundTransparency = 1
}, statsContainer)

local playerNameLabel = createInstance("TextLabel", {
	Name = "PlayerName",
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 18,
	Text = LP.Name
}, playerInfo)

createInstance("TextLabel", {
	Name = "PlayerLabel",
	Size = UDim2.new(1, 0, 0, 20),
	Position = UDim2.new(0, 0, 1, -20),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 14,
	Text = "Current Player"
}, playerInfo)

local searchBar = createCard(UDim2.new(1, -40, 0, 40), UDim2.new(0, 20, 0, 90), Color3.fromRGB(50, 50, 55), housesContent)
createInstance("ImageLabel", {
	Name = "SearchIcon",
	Size = UDim2.new(0, 20, 0, 20),
	Position = UDim2.new(0, 15, 0.5, -10),
	BackgroundTransparency = 1,
	Image = "rbxassetid://3605022185",
	ImageColor3 = Color3.fromRGB(180, 180, 180)
}, searchBar)

local searchBox = createInstance("TextBox", {
	Name = "SearchBox",
	Size = UDim2.new(1, -50, 1, -10),
	Position = UDim2.new(0, 45, 0, 5),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	PlaceholderText = "Search by ID or owner...",
	PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
	Text = "",
	ClearTextOnFocus = false
}, searchBar)

local housesScroll = createInstance("ScrollingFrame", {
	Name = "HousesScroll",
	Size = UDim2.new(1, -40, 1, -140),
	Position = UDim2.new(0, 20, 0, 140),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
	CanvasSize = UDim2.new(0, 0, 0, 0)
}, housesContent)

local housesList = createInstance("UIListLayout", {
	Padding = UDim.new(0, 10)
}, housesScroll)

local infoScroll = createInstance("ScrollingFrame", {
	Name = "InfoScroll",
	Size = UDim2.new(1, -40, 1, 0),
	Position = UDim2.new(0, 20, 0, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
	CanvasSize = UDim2.new(0, 0, 0, 0)
}, infoContent)

local infoLayout = createInstance("UIListLayout", {
	Padding = UDim.new(0, 15)
}, infoScroll)

local appInfoCard = createCard(UDim2.new(1, 0, 0, 150), nil, nil, infoScroll)
local appTitle = createInstance("TextLabel", {
	Name = "AppTitle",
	Size = UDim2.new(1, -30, 0, 40),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 24,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "House Cloner Pro"
}, appInfoCard)

local appVersion = createInstance("TextLabel", {
	Name = "AppVersion",
	Size = UDim2.new(1, -30, 0, 20),
	Position = UDim2.new(0, 15, 0, 55),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Version 0.1"
}, appInfoCard)

local appCreator = createInstance("TextLabel", {
	Name = "AppCreator",
	Size = UDim2.new(1, -30, 0, 20),
	Position = UDim2.new(0, 15, 0, 80),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Created by: OneCreatorX"
}, appInfoCard)

createInstance("TextLabel", {
	Name = "AppDescription",
	Size = UDim2.new(1, -30, 0, 40),
	Position = UDim2.new(0, 15, 0, 105),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(180, 180, 180),
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextWrapped = true,
	Text = "Clone and save house designs with ease. Customize your experience with this powerful tool."
}, appInfoCard)

local socialCard = createCard(UDim2.new(1, 0, 0, 120), nil, nil, infoScroll)
createInstance("TextLabel", {
	Name = "SocialTitle",
	Size = UDim2.new(1, -30, 0, 30),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Social"
}, socialCard)

local socialLayout = createInstance("UIGridLayout", {
	CellSize = UDim2.new(0.33, -15, 0, 40),
	CellPadding = UDim2.new(0, 10, 0, 10),
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Center
}, socialCard)

local discordButton = createButton({
	Name = "DiscordButton",
	BackgroundColor3 = Color3.fromRGB(88, 101, 242),
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14,
	Text = "DISCORD"
}, socialCard)

local youtubeButton = createButton({
	Name = "YoutubeButton",
	BackgroundColor3 = Color3.fromRGB(255, 0, 0),
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14,
	Text = "YOUTUBE"
}, socialCard)

local websiteButton = createButton({
	Name = "WebsiteButton",
	BackgroundColor3 = Color3.fromRGB(60, 120, 190),
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14,
	Text = "WEBSITE"
}, socialCard)

local privacyCard = createCard(UDim2.new(1, 0, 0, 120), nil, nil, infoScroll)
createInstance("TextLabel", {
	Name = "PrivacyTitle",
	Size = UDim2.new(1, -30, 0, 30),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Privacy Settings"
}, privacyCard)

local hideUsernameButton = createButton({
	Name = "HideUsernameButton",
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(0, 15, 0, 55),
	BackgroundColor3 = Color3.fromRGB(60, 60, 65),
	Text = ""
}, privacyCard)

createInstance("TextLabel", {
	Name = "HideUsernameLabel",
	Size = UDim2.new(0, 150, 0, 20),
	Position = UDim2.new(0, 55, 0, 60),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Hide Username"
}, privacyCard)

local hideHouseInfoButton = createButton({
	Name = "HideHouseInfoButton",
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(0, 15, 0, 95),
	BackgroundColor3 = Color3.fromRGB(60, 60, 65),
	Text = ""
}, privacyCard)

createInstance("TextLabel", {
	Name = "HideHouseInfoLabel",
	Size = UDim2.new(0, 150, 0, 20),
	Position = UDim2.new(0, 55, 0, 100),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	Text = "Hide House Info"
}, privacyCard)

local function updatePrivacyButton(button, isActive)
	if isActive then
		button.BackgroundColor3 = Color3.fromRGB(60, 170, 100)
		local checkmark = Instance.new("TextLabel")
		checkmark.Name = "Checkmark"
		checkmark.Size = UDim2.new(1, 0, 1, 0)
		checkmark.BackgroundTransparency = 1
		checkmark.Font = Enum.Font.GothamBold
		checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
		checkmark.TextSize = 18
		checkmark.Text = "✓"
		checkmark.Parent = button
	else
		pcall(function()
			button.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
			local checkmark = button:FindFirstChild("Checkmark")
			if checkmark then
				checkmark:Destroy()
			end
		end)
	end
end

local function isValidHouseData(data)
	if not data or #data < 3 then return false end
	if data[2] ~= "house_interior" then return false end
	local houseInfo = data[3]
	return type(houseInfo) == "table" and houseInfo.house_id and houseInfo.building_type and houseInfo.unique and houseInfo.furniture
end

local function updateHouseCount()
	local count = 0
	for _ in pairs(savedHouses) do
		count = count + 1
	end
	countValue.Text = tostring(count)
end

local function shouldHideOwner(owner)
	return hideUsername and (owner == LP.Name or owner:find(LP.Name))
end

local function createHouseCard(house)
	local card = createCard(UDim2.new(1, 0, 0, 120), nil, nil, housesScroll)
	card.Name = "HouseCard_" .. house.uid:sub(-6)
	local houseTypeTag = createFrame({
		Name = "HouseTypeTag",
		Size = UDim2.new(0, 100, 0, 24),
		Position = UDim2.new(0, 15, 0, 15),
		BackgroundColor3 = Color3.fromRGB(60, 120, 190),
		BorderSizePixel = 0
	}, card)
	createInstance("UICorner", {CornerRadius = UDim.new(0, 12)}, houseTypeTag)
	createInstance("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12,
		Text = house.building_type:gsub("_", " "):upper()
	}, houseTypeTag)
	local isLocalPlayerHouse = shouldHideOwner(house.owner)
	local houseIdLabel = createInstance("TextLabel", {
		Name = "HouseId",
		Size = UDim2.new(0, 200, 0, 20),
		Position = UDim2.new(0, 15, 0, 50),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "ID: " .. ((hideHouseInfo or isLocalPlayerHouse) and "Hidden" or house.house_id)
	}, card)
	local houseOwnerLabel = createInstance("TextLabel", {
		Name = "HouseOwner",
		Size = UDim2.new(0, 200, 0, 20),
		Position = UDim2.new(0, 15, 0, 75),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "Owner: " .. ((hideHouseInfo or isLocalPlayerHouse) and "Hidden" or house.owner)
	}, card)
	local uniqueIdLabel = createInstance("TextLabel", {
		Name = "UniqueId",
		Size = UDim2.new(0, 200, 0, 20),
		Position = UDim2.new(0, 15, 0, 95),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(150, 150, 150),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "UID: " .. ((hideHouseInfo or isLocalPlayerHouse) and "Hidden" or house.uid:sub(-12))
	}, card)
	local count = 0
	for _ in pairs(house.furn) do
		count = count + 1
	end
	createInstance("TextLabel", {
		Name = "FurnitureCount",
		Size = UDim2.new(0, 100, 0, 20),
		Position = UDim2.new(1, -115, 0, 15),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(150, 150, 150),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		Text = count .. " items"
	}, card)
	local cloneButton = createButton({
		Name = "CloneButton",
		Size = UDim2.new(0, 100, 0, 36),
		Position = UDim2.new(1, -115, 0, 70),
		BackgroundColor3 = Color3.fromRGB(60, 170, 100),
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		Text = "CLONE"
	}, card)
	cloneButton.MouseButton1Click:Connect(function()
		local originalColor = cloneButton.BackgroundColor3
		cloneButton.BackgroundColor3 = Color3.fromRGB(40, 130, 70)
		cloneButton.Text = "CLONING..."
		for _, item in pairs(house.furn) do
			local furnitureData = {{
				kind = item.id,
				properties = {
					cframe = item.cframe,
					colors = item.colors,
					scale = item.scale
				}
			}}
			
			local success, result = pcall(function()
				return FurnitureRegistry.buy_furniture(furnitureData)
			end)
			
			if success then
				print("Mueble clonado:", item.id)
			else
				warn("Error al clonar mueble:", item.id, result)
			end
		end
		task.delay(1, function()
			cloneButton.BackgroundColor3 = originalColor
			cloneButton.Text = "CLONE"
		end)
	end)
	housesScroll.CanvasSize = UDim2.new(0, 0, 0, housesList.AbsoluteContentSize.Y)
	return card
end

local function processHouseData(rawData)
	if not isValidHouseData(rawData) then return end
	local houseInfo = rawData[3]
	local uid = houseInfo.unique
	if not savedHouses[uid] then
		savedHouses[uid] = {
			house_id = houseInfo.house_id,
			building_type = houseInfo.building_type,
			owner = rawData[1],
			uid = uid,
			listed = houseInfo.listed_for_trade,
			furn = {}
		}
		for id, item in pairs(houseInfo.furniture) do
			if item.id and item.cframe then
				local components = type(item.cframe) == "table" and item.cframe or {item.cframe:GetComponents()}
				local colors = item.colors or {}
				
				if item.colors and next(item.colors) and typeof(item.colors[1]) ~= "Color3" then
					colors = processRawColors(item.colors)
				end
				
				savedHouses[uid].furn[id] = {
					id = item.id,
					cframe = CFrame.new(table.unpack(components)),
					colors = colors,
					scale = item.scale or 1,
					unique = id
				}
			end
		end
		createHouseCard(savedHouses[uid])
		updateHouseCount()
	end
end

for _, remote in pairs(API:GetChildren()) do
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			processHouseData({...})
		end)
	end
end

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

minimizeButton.MouseButton1Click:Connect(function()
	local isMinimized = mainFrame.Size.Y.Offset == 50
	local targetSize, targetPosition
	if not isMinimized then
		targetSize = UDim2.new(0, 400, 0, 50)
		targetPosition = UDim2.new(1, -420, 0, 20)
	else
		targetSize = UDim2.new(0, 400, 0, 500)
		targetPosition = UDim2.new(1, -420, 0.5, 0)
	end
	local sizeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = targetSize,
		Position = targetPosition
	})
	sizeTween:Play()
end)

searchBox.Changed:Connect(function(prop)
	if prop == "Text" then
		local searchText = searchBox.Text:lower()
		for _, child in pairs(housesScroll:GetChildren()) do
			if child:IsA("Frame") and child.Name:find("HouseCard_") then
				if searchText == "" then
					child.Visible = true
				else
					local houseId = child.HouseId.Text:lower()
					local houseOwner = child.HouseOwner.Text:lower()
					local uniqueId = child.UniqueId.Text:lower()
					if houseId:find(searchText) or houseOwner:find(searchText) or uniqueId:find(searchText) then
						child.Visible = true
					else
						child.Visible = false
					end
				end
			end
		end
	end
end)

local function copyToClipboard(text, button)
	local originalText = button.Text
	if setclipboard then
		setclipboard(text)
		button.Text = "COPIED!"
		task.delay(1.5, function()
			button.Text = originalText
		end)
	end
end

discordButton.MouseButton1Click:Connect(function()
	copyToClipboard("https://discord.gg/RCDQjQ9He6", discordButton)
end)

youtubeButton.MouseButton1Click:Connect(function()
	copyToClipboard("https://youtube.com/@onecreatorx", youtubeButton)
end)

websiteButton.MouseButton1Click:Connect(function()
	copyToClipboard("https://https://repository.api-x.site", websiteButton)
end)

hideUsernameButton.MouseButton1Click:Connect(function()
	hideUsername = not hideUsername
	updatePrivacyButton(hideUsernameButton, hideUsername)
	playerNameLabel.Text = hideUsername and "Hidden" or LP.Name
end)

hideHouseInfoButton.MouseButton1Click:Connect(function()
	hideHouseInfo = not hideHouseInfo
	updatePrivacyButton(hideHouseInfoButton, hideHouseInfo)
end)

housesTab.MouseButton1Click:Connect(function()
	housesTab.BackgroundColor3 = Color3.fromRGB(60, 120, 190)
	housesTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	infoTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	infoTab.TextColor3 = Color3.fromRGB(180, 180, 180)
	housesContent.Visible = true
	infoContent.Visible = false
end)

infoTab.MouseButton1Click:Connect(function()
	infoTab.BackgroundColor3 = Color3.fromRGB(60, 120, 190)
	infoTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	housesTab.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	housesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
	housesContent.Visible = false
	infoContent.Visible = true
end)

local function updateCanvasSizes()
	housesScroll.CanvasSize = UDim2.new(0, 0, 0, housesList.AbsoluteContentSize.Y)
	infoScroll.CanvasSize = UDim2.new(0, 0, 0, infoLayout.AbsoluteContentSize.Y + 20)
end

updateCanvasSizes()

local function resizeUI()
	local viewportSize = workspace.CurrentCamera.ViewportSize
	if viewportSize.X < 800 then
		mainFrame.Size = UDim2.new(0, math.min(350, viewportSize.X * 0.8), 0, math.min(500, viewportSize.Y * 0.8))
		mainFrame.Position = UDim2.new(1, -mainFrame.Size.X.Offset - 20, 0.5, 0)
		appTitle.TextSize = 20
		appVersion.TextSize = 14
		appCreator.TextSize = 14
		searchBox.TextSize = 14
	else
		mainFrame.Size = UDim2.new(0, 400, 0, 500)
		mainFrame.Position = UDim2.new(1, -420, 0.5, 0)
		appTitle.TextSize = 24
		appVersion.TextSize = 16
		appCreator.TextSize = 16
		searchBox.TextSize = 16
	end
	updateCanvasSizes()
end

resizeUI()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resizeUI)

local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
