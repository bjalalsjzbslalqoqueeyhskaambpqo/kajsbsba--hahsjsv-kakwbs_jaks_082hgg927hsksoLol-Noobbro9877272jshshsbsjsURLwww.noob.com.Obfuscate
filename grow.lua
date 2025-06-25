local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player.PlayerGui

-- Validation
local validationResponse = _G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if validationResponse ~= "1" then return end

-- Disable VariantVisuals if present
local variantMod = nil
for _, module in ipairs(getloadedmodules()) do
    if module.Name == "VariantVisuals" then
        variantMod = require(module)
        break
    end
end
if variantMod then
    variantMod.SetVisuals = function() end
end

-- Advanced Cache System
local Cache = {}
Cache.__index = Cache

function Cache.new()
    local self = setmetatable({
        data = {},
        timestamps = {},
        ttl = 30
    }, Cache)
    return self
end

function Cache:set(key, value, customTTL)
    self.data[key] = value
    self.timestamps[key] = tick() + (customTTL or self.ttl)
end

function Cache:get(key)
    if self:isValid(key) then
        return self.data[key]
    end
    return nil
end

function Cache:isValid(key)
    return self.timestamps[key] and tick() < self.timestamps[key]
end

function Cache:invalidate(key)
    self.data[key] = nil
    self.timestamps[key] = nil
end

function Cache:replace(key, value, customTTL)
    self:invalidate(key)
    self:set(key, value, customTTL)
end

local cache = Cache.new()

-- Configuration Manager
local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager.new()
    local self = setmetatable({
        configFile = "AdvancedAutoShopConfig.json",
        defaultConfig = {
            activeTab = 1,
            collect = false,
            autoSell = false,
            autoPlant = false,
            autoEvent = false,
            selectedPlants = {},
            petEggs = {},
            gears = {},
            seeds = {},
            petFeeding = {}
        }
    }, ConfigManager)
    return self
end

function ConfigManager:save(config)
    local success, result = pcall(function()
        writefile(self.configFile, HttpService:JSONEncode(config))
    end)
    if not success then
        warn("Failed to save config:", result)
    end
end

function ConfigManager:load()
    if isfile(self.configFile) then
        local success, config = pcall(function()
            return HttpService:JSONDecode(readfile(self.configFile))
        end)
        if success and config then
            return config
        end
    end
    return self.defaultConfig
end

local configManager = ConfigManager.new()
local config = configManager:load()

-- UI Theme
local Theme = {
    colors = {
        primary = Color3.fromRGB(20, 20, 25),
        secondary = Color3.fromRGB(30, 30, 35),
        accent = Color3.fromRGB(0, 120, 50),
        accentHover = Color3.fromRGB(0, 150, 70),
        text = Color3.fromRGB(255, 255, 255),
        textSecondary = Color3.fromRGB(200, 200, 210),
        border = Color3.fromRGB(80, 80, 90),
        shadow = Color3.fromRGB(0, 0, 0),
        inactive = Color3.fromRGB(50, 50, 60)
    },
    sizes = {
        mainFrame = UDim2.new(0, 400, 0, 500),
        tabButton = UDim2.new(0, 80, 0, 30),
        button = UDim2.new(0, 120, 0, 25),
        smallButton = UDim2.new(0, 80, 0, 20)
    }
}

-- UI Builder
local UIBuilder = {}
UIBuilder.__index = UIBuilder

function UIBuilder.new()
    return setmetatable({}, UIBuilder)
end

function UIBuilder:createFrame(parent, size, position, color, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(1, 0, 1, 0)
    frame.Position = position or UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = color or Theme.colors.primary
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    if cornerRadius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, cornerRadius)
        corner.Parent = frame
    end
    
    return frame
end

function UIBuilder:createButton(parent, size, position, text, callback)
    local button = Instance.new("TextButton")
    button.Size = size or Theme.sizes.button
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Theme.colors.inactive
    button.Text = text or ""
    button.TextColor3 = Theme.colors.text
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.colors.border
    stroke.Thickness = 1
    stroke.Parent = button
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button, stroke
end

function UIBuilder:createScrollFrame(parent, size, position)
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = size or UDim2.new(1, -20, 1, -60)
    scrollFrame.Position = position or UDim2.new(0, 10, 0, 50)
    scrollFrame.BackgroundColor3 = Theme.colors.secondary
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Theme.colors.border
    scrollFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = scrollFrame
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.Padding = UDim.new(0, 5)
    layout.Parent = scrollFrame
    
    return scrollFrame, layout
end

local uiBuilder = UIBuilder.new()

-- Main GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedAutoShopMenu"
screenGui.Parent = playerGui

local mainFrame = uiBuilder:createFrame(screenGui, Theme.sizes.mainFrame, UDim2.new(0, 10, 0, 10), Theme.colors.primary, 15)
mainFrame.Draggable = true
mainFrame.Active = true

-- Add shadow
local shadow = uiBuilder:createFrame(mainFrame, UDim2.new(1, 6, 1, 6), UDim2.new(0, -3, 0, 3), Theme.colors.shadow, 15)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = -1

-- Add stroke
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Theme.colors.border
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Title bar
local titleBar = uiBuilder:createFrame(mainFrame, UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 0, 5), Theme.colors.accent, 10)
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 150, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 100, 50))
}
titleGradient.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🛍️ Advanced Auto Shop"
titleLabel.TextColor3 = Theme.colors.text
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Minimize button
local minimizeButton, _ = uiBuilder:createButton(titleBar, UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5), "-")
local isMinimized = false

-- Tab System
local tabContainer = uiBuilder:createFrame(mainFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 45), Theme.colors.secondary, 8)
local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabContainer

local contentContainer = uiBuilder:createFrame(mainFrame, UDim2.new(1, -20, 1, -130), UDim2.new(0, 10, 0, 90), Theme.colors.secondary, 8)

-- Tab data
local tabs = {
    {name = "Control", icon = "⚙️"},
    {name = "Plants", icon = "🌱"},
    {name = "Shop", icon = "🛒"},
    {name = "Pets", icon = "🐾"},
    {name = "Events", icon = "🎉"}
}

local tabButtons = {}
local tabContents = {}
local activeTab = config.activeTab or 1

-- Performance optimized functions
local function optimizedIteration(collection, callback, batchSize)
    batchSize = batchSize or 50
    local count = 0
    
    for key, value in pairs(collection) do
        callback(key, value)
        count = count + 1
        
        if count >= batchSize then
            count = 0
            RunService.Heartbeat:Wait()
        end
    end
end

local function smartConnection(signal, callback, debounceTime)
    debounceTime = debounceTime or 0.1
    local lastCall = 0
    
    return signal:Connect(function(...)
        local now = tick()
        if now - lastCall >= debounceTime then
            lastCall = now
            callback(...)
        end
    end)
end

-- Game Data Fetchers with Caching
local GameData = {}

function GameData.getPlayerPlot()
    local cacheKey = "playerPlot"
    local cached = cache:get(cacheKey)
    if cached then return cached end
    
    for _, farm in pairs(workspace.Farm:GetChildren()) do
        local important = farm:FindFirstChild("Important")
        local data = important and important:FindFirstChild("Data")
        local owner = data and data:FindFirstChild("Owner")
        
        if owner and owner.Value == player.Name then
            cache:set(cacheKey, important, 60)
            return important
        end
    end
    
    return nil
end

function GameData.getPlantNames()
    local cacheKey = "plantNames"
    local cached = cache:get(cacheKey)
    if cached then return cached end
    
    local plot = GameData.getPlayerPlot()
    if not plot then return {} end
    
    local plantNames = {}
    local seen = {}
    
    for _, plant in pairs(plot.Plants_Physical:GetChildren()) do
        if plant:IsA("Model") and not seen[plant.Name] then
            seen[plant.Name] = true
            table.insert(plantNames, plant.Name)
        end
    end
    
    cache:set(cacheKey, plantNames, 30)
    return plantNames
end

function GameData.getPetEggs()
    local cacheKey = "petEggs"
    local cached = cache:get(cacheKey)
    if cached then return cached end
    
    local petRegistry = ReplicatedStorage:WaitForChild("Data"):WaitForChild("PetRegistry")
    local eggs = require(petRegistry).PetEggs
    
    cache:set(cacheKey, eggs, 300)
    return eggs
end

-- Automation Functions
local AutomationManager = {}
AutomationManager.__index = AutomationManager

function AutomationManager.new()
    local self = setmetatable({
        connections = {},
        loops = {}
    }, AutomationManager)
    return self
end

function AutomationManager:startCollecting()
    if self.loops.collect then return end
    
    self.loops.collect = task.spawn(function()
        while config.collect do
            local plot = GameData.getPlayerPlot()
            if plot then
                local count = 0
                local maxBatch = 200
                
                optimizedIteration(plot.Plants_Physical:GetChildren(), function(_, plant)
                    if count >= maxBatch then return end
                    if not plant:IsA("Model") or not config.selectedPlants[plant.Name] then return end
                    
                    local fruits = plant:FindFirstChild("Fruits")
                    if fruits then
                        for _, fruit in pairs(fruits:GetChildren()) do
                            if count >= maxBatch then break end
                            ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {fruit})
                            count = count + 1
                            RunService.Heartbeat:Wait()
                        end
                    else
                        ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {plant})
                        count = count + 1
                        RunService.Heartbeat:Wait()
                    end
                end, 10)
            end
            task.wait(5)
        end
        self.loops.collect = nil
    end)
end

function AutomationManager:startAutoSell()
    if self.loops.autoSell then return end
    
    self.loops.autoSell = task.spawn(function()
        while config.autoSell do
            ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
            task.wait(0.5)
        end
        self.loops.autoSell = nil
    end)
end

function AutomationManager:startAutoPlant()
    if not config.autoPlant then return end
    
    local character = player.Character
    if not character then return end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local seedName = tool.Name:gsub(" Seed %[X%d+%]", ""):gsub(" Seed", "")
    local plot = GameData.getPlayerPlot()
    
    if plot then
        local plants = plot:FindFirstChild("Plants_Physical")
        if plants then
            local plant = plants:FindFirstChild(seedName)
            if plant and plant.PrimaryPart then
                local position = plant.PrimaryPart.Position
                
                self.loops.autoPlant = task.spawn(function()
                    while config.autoPlant do
                        local currentTool = character:FindFirstChildOfClass("Tool")
                        if not currentTool or not currentTool.Name:find(seedName) then break end
                        
                        ReplicatedStorage.GameEvents.Plant_RE:FireServer(position, seedName)
                        task.wait(0.1)
                    end
                    self.loops.autoPlant = nil
                end)
            end
        end
    end
end

function AutomationManager:stopLoop(loopName)
    if self.loops[loopName] then
        task.cancel(self.loops[loopName])
        self.loops[loopName] = nil
    end
end

local automationManager = AutomationManager.new()

-- Tab Creation Functions
local function createControlTab()
    local content = uiBuilder:createFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    content.BackgroundTransparency = 1
    
    local scrollFrame, layout = uiBuilder:createScrollFrame(content, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5))
    
    -- Main controls section
    local controlSection = uiBuilder:createFrame(scrollFrame, UDim2.new(1, -8, 0, 120), UDim2.new(0, 0, 0, 0), Theme.colors.secondary, 12)
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, -10, 0, 25)
    sectionTitle.Position = UDim2.new(0, 5, 0, 5)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = "⚙️ Main Controls"
    sectionTitle.TextColor3 = Theme.colors.textSecondary
    sectionTitle.TextSize = 14
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = controlSection
    
    -- Control buttons
    local collectButton, collectStroke = uiBuilder:createButton(controlSection, UDim2.new(0.48, 0, 0, 25), UDim2.new(0, 5, 0, 35))
    local sellButton, sellStroke = uiBuilder:createButton(controlSection, UDim2.new(0.48, 0, 0, 25), UDim2.new(0.52, 0, 0, 35))
    local plantButton, plantStroke = uiBuilder:createButton(controlSection, UDim2.new(0.48, 0, 0, 25), UDim2.new(0, 5, 0, 65))
    local eventButton, eventStroke = uiBuilder:createButton(controlSection, UDim2.new(0.48, 0, 0, 25), UDim2.new(0.52, 0, 0, 65))
    
    local function updateButton(button, stroke, isActive, text)
        button.Text = text .. (isActive and " ON" or " OFF")
        button.BackgroundColor3 = isActive and Theme.colors.accent or Theme.colors.inactive
        stroke.Color = isActive and Theme.colors.accentHover or Theme.colors.border
    end
    
    local function updateAllButtons()
        updateButton(collectButton, collectStroke, config.collect, "📦 Collect:")
        updateButton(sellButton, sellStroke, config.autoSell, "💰 Auto Sell:")
        updateButton(plantButton, plantStroke, config.autoPlant, "🌿 Auto Plant:")
        updateButton(eventButton, eventStroke, config.autoEvent, "🍓 Auto Event:")
    end
    
    collectButton.MouseButton1Click:Connect(function()
        config.collect = not config.collect
        updateAllButtons()
        
        if config.collect then
            automationManager:startCollecting()
        else
            automationManager:stopLoop("collect")
        end
        
        configManager:save(config)
    end)
    
    sellButton.MouseButton1Click:Connect(function()
        config.autoSell = not config.autoSell
        updateAllButtons()
        
        if config.autoSell then
            automationManager:startAutoSell()
        else
            automationManager:stopLoop("autoSell")
        end
        
        configManager:save(config)
    end)
    
    plantButton.MouseButton1Click:Connect(function()
        config.autoPlant = not config.autoPlant
        updateAllButtons()
        configManager:save(config)
    end)
    
    eventButton.MouseButton1Click:Connect(function()
        config.autoEvent = not config.autoEvent
        updateAllButtons()
        configManager:save(config)
    end)
    
    updateAllButtons()
    
    -- Update canvas size
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    return content
end

local function createPlantsTab()
    local content = uiBuilder:createFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    content.BackgroundTransparency = 1
    
    local scrollFrame, layout = uiBuilder:createScrollFrame(content, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5))
    
    local function updatePlantButtons()
        -- Clear existing buttons
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local plantNames = GameData.getPlantNames()
        
        for _, plantName in pairs(plantNames) do
            local button, stroke = uiBuilder:createButton(scrollFrame, UDim2.new(1, -8, 0, 30), UDim2.new(0, 0, 0, 0))
            
            local isSelected = config.selectedPlants[plantName] or false
            button.Text = "🌱 " .. plantName .. ": " .. (isSelected and "ON" or "OFF")
            button.BackgroundColor3 = isSelected and Theme.colors.accent or Theme.colors.inactive
            stroke.Color = isSelected and Theme.colors.accentHover or Theme.colors.border
            button.TextXAlignment = Enum.TextXAlignment.Left
            
            button.MouseButton1Click:Connect(function()
                config.selectedPlants[plantName] = not config.selectedPlants[plantName]
                local newState = config.selectedPlants[plantName]
                
                button.Text = "🌱 " .. plantName .. ": " .. (newState and "ON" or "OFF")
                button.BackgroundColor3 = newState and Theme.colors.accent or Theme.colors.inactive
                stroke.Color = newState and Theme.colors.accentHover or Theme.colors.border
                
                configManager:save(config)
            end)
        end
        
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
    end
    
    -- Refresh button
    local refreshButton = uiBuilder:createButton(content, UDim2.new(0, 100, 0, 25), UDim2.new(1, -110, 0, 5), "🔄 Refresh")
    refreshButton.MouseButton1Click:Connect(function()
        cache:invalidate("plantNames")
        updatePlantButtons()
    end)
    
    updatePlantButtons()
    
    return content
end

local function createShopTab()
    local content = uiBuilder:createFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    content.BackgroundTransparency = 1
    
    local scrollFrame, layout = uiBuilder:createScrollFrame(content, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5))
    
    -- Gear shop integration
    task.spawn(function()
        local gearShop = playerGui:WaitForChild("Gear_Shop")
        local gearFrame = gearShop.Frame.ScrollingFrame
        local buyGearEvent = ReplicatedStorage.GameEvents.BuyGearStock
        
        for _, item in pairs(gearFrame:GetChildren()) do
            local frame2 = item:FindFirstChild("Frame")
            local shecklesBuy = frame2 and frame2:FindFirstChild("Sheckles_Buy")
            local inStock = shecklesBuy and shecklesBuy:FindFirstChild("In_Stock")
            
            if inStock then
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0, 20, 0, 20)
                button.Position = UDim2.new(1, -22, 0, 2)
                button.BackgroundColor3 = config.gears[item.Name] and Theme.colors.accent or Theme.colors.inactive
                button.Text = ""
                button.Parent = shecklesBuy
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 4)
                corner.Parent = button
                
                local isActive = config.gears[item.Name] or false
                
                button.MouseButton1Click:Connect(function()
                    isActive = not isActive
                    config.gears[item.Name] = isActive
                    button.BackgroundColor3 = isActive and Theme.colors.accent or Theme.colors.inactive
                    configManager:save(config)
                end)
                
                task.spawn(function()
                    while true do
                        if isActive and inStock.Visible then
                            buyGearEvent:FireServer(item.Name)
                        end
                        task.wait(0.15)
                    end
                end)
            end
        end
    end)
    
    -- Seed shop integration
    task.spawn(function()
        local seedShop = playerGui:WaitForChild("Seed_Shop")
        local seedFrame = seedShop.Frame.ScrollingFrame
        local buySeedEvent = ReplicatedStorage.GameEvents.BuySeedStock
        
        for _, item in pairs(seedFrame:GetChildren()) do
            if item:IsA("Frame") and item:FindFirstChild("Frame") then
                local shecklesBuy = item.Frame:FindFirstChild("Sheckles_Buy")
                if shecklesBuy then
                    local button = Instance.new("TextButton")
                    button.Size = UDim2.new(0, 22, 0, 22)
                    button.Position = UDim2.new(1, -27, 0, 4)
                    button.BackgroundColor3 = Color3.new(1, 1, 1)
                    button.Text = ""
                    button.Parent = shecklesBuy
                    button.BorderSizePixel = 1
                    button.AutoButtonColor = false
                    
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 4)
                    corner.Parent = button
                    
                    local checkmark = Instance.new("Frame")
                    checkmark.Size = UDim2.new(1, -6, 1, -6)
                    checkmark.Position = UDim2.new(0, 3, 0, 3)
                    checkmark.BackgroundColor3 = Theme.colors.accent
                    checkmark.Visible = config.seeds[item.Name] or false
                    checkmark.Parent = button
                    
                    local checkCorner = Instance.new("UICorner")
                    checkCorner.CornerRadius = UDim.new(0, 2)
                    checkCorner.Parent = checkmark
                    
                    button.MouseButton1Click:Connect(function()
                        config.seeds[item.Name] = not config.seeds[item.Name]
                        checkmark.Visible = config.seeds[item.Name]
                        
                        if config.seeds[item.Name] then
                            task.spawn(function()
                                while config.seeds[item.Name] do
                                    local currentItem = seedFrame:FindFirstChild(item.Name)
                                    if not currentItem then break end
                                    
                                    local currentSheckles = currentItem.Frame:FindFirstChild("Sheckles_Buy")
                                    local currentStock = currentSheckles and currentSheckles:FindFirstChild("In_Stock")
                                    
                                    if currentStock and currentStock.Visible then
                                        buySeedEvent:FireServer(item.Name)
                                    else
                                        repeat 
                                            task.wait(0.05)
                                            currentStock = currentSheckles and currentSheckles:FindFirstChild("In_Stock")
                                        until (currentStock and currentStock.Visible) or not config.seeds[item.Name]
                                    end
                                    task.wait()
                                end
                            end)
                        end
                        
                        configManager:save(config)
                    end)
                end
            end
        end
    end)
    
    return content
end

local function createPetsTab()
    local content = uiBuilder:createFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    content.BackgroundTransparency = 1
    
    local scrollFrame, layout = uiBuilder:createScrollFrame(content, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5))
    
    -- Pet eggs section
    local eggs = GameData.getPetEggs()
    local buyPetEggEvent = ReplicatedStorage.GameEvents.BuyPetEgg
    
    for eggName in pairs(eggs) do
        local button, stroke = uiBuilder:createButton(scrollFrame, UDim2.new(1, -8, 0, 35), UDim2.new(0, 0, 0, 0))
        
        local isActive = config.petEggs[eggName] or false
        button.Text = "🥚 " .. eggName .. ": " .. (isActive and "ON" or "OFF")
        button.BackgroundColor3 = isActive and Theme.colors.accent or Theme.colors.inactive
        stroke.Color = isActive and Theme.colors.accentHover or Theme.colors.border
        button.TextXAlignment = Enum.TextXAlignment.Left
        
        button.MouseButton1Click:Connect(function()
            config.petEggs[eggName] = not config.petEggs[eggName]
            local newState = config.petEggs[eggName]
            
            button.Text = "🥚 " .. eggName .. ": " .. (newState and "ON" or "OFF")
            button.BackgroundColor3 = newState and Theme.colors.accent or Theme.colors.inactive
            stroke.Color = newState and Theme.colors.accentHover or Theme.colors.border
            
            if newState then
                task.spawn(function()
                    while config.petEggs[eggName] do
                        local dataService = require(ReplicatedStorage.Modules.DataService)
                        local data = dataService:GetData()
                        
                        for index, stock in pairs(data.PetEggStock.Stocks) do
                            if config.petEggs[eggName] and eggs[stock.EggName] and stock.EggName == eggName and stock.Stock > 0 then
                                buyPetEggEvent:FireServer(index)
                            end
                        end
                        task.wait(0.1)
                    end
                end)
            end
            
            configManager:save(config)
        end)
    end
    
    -- Pet feeding section
    task.spawn(function()
        local activePetUI = playerGui:WaitForChild("ActivePetUI")
        local petsScrollFrame = activePetUI.Frame.Main.ScrollingFrame
        local feedEvent = ReplicatedStorage.GameEvents.ActivePetService
        
        for _, petFrame in pairs(petsScrollFrame:GetChildren()) do
            if petFrame.Name:match("^%b{}$") and petFrame:FindFirstChild("PetStats") then
                local stats = petFrame.PetStats
                local button, stroke = uiBuilder:createButton(stats, UDim2.new(1, -4, 0, 20), UDim2.new(0, 2, 0, 2), "Auto Feed: OFF")
                
                local petId = petFrame.Name
                local isActive = config.petFeeding[petId] or false
                
                local function updateFeedButton()
                    button.Text = "Auto Feed: " .. (isActive and "ON" or "OFF")
                    button.BackgroundColor3 = isActive and Theme.colors.accent or Theme.colors.inactive
                    stroke.Color = isActive and Theme.colors.accentHover or Theme.colors.border
                end
                
                local function equipAllTools()
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
                            tool.Parent = player.Character
                        end
                    end
                end
                
                local function feedLoop()
                    while isActive do
                        equipAllTools()
                        feedEvent:FireServer("Feed", petId)
                        RunService.Heartbeat:Wait()
                    end
                end
                
                smartConnection(player.Backpack.ChildAdded, function(tool)
                    if isActive and tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
                        tool.Parent = player.Character
                    end
                end)
                
                button.MouseButton1Click:Connect(function()
                    isActive = not isActive
                    config.petFeeding[petId] = isActive
                    updateFeedButton()
                    
                    if isActive then
                        equipAllTools()
                        task.spawn(feedLoop)
                    end
                    
                    configManager:save(config)
                end)
                
                updateFeedButton()
            end
        end
    end)
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    return content
end

local function createEventsTab()
    local content = uiBuilder:createFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    content.BackgroundTransparency = 1
    
    local scrollFrame, layout = uiBuilder:createScrollFrame(content, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5))
    
    -- Summer Harvest Event
    local eventSection = uiBuilder:createFrame(scrollFrame, UDim2.new(1, -8, 0, 80), UDim2.new(0, 0, 0, 0), Theme.colors.secondary, 12)
    
    local eventTitle = Instance.new("TextLabel")
    eventTitle.Size = UDim2.new(1, -10, 0, 25)
    eventTitle.Position = UDim2.new(0, 5, 0, 5)
    eventTitle.BackgroundTransparency = 1
    eventTitle.Text = "🍓 Summer Harvest Event"
    eventTitle.TextColor3 = Theme.colors.textSecondary
    eventTitle.TextSize = 14
    eventTitle.Font = Enum.Font.GothamBold
    eventTitle.TextXAlignment = Enum.TextXAlignment.Left
    eventTitle.Parent = eventSection
    
    local eventButton, eventStroke = uiBuilder:createButton(eventSection, UDim2.new(0.6, 0, 0, 30), UDim2.new(0, 5, 0, 35))
    
    local function updateEventButton()
        eventButton.Text = "🍓 Auto Event: " .. (config.autoEvent and "ON" or "OFF")
        eventButton.BackgroundColor3 = config.autoEvent and Theme.colors.accent or Theme.colors.inactive
        eventStroke.Color = config.autoEvent and Theme.colors.accentHover or Theme.colors.border
    end
    
    local function findEventLabel()
        for _, obj in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:find("Summer Harvest Ends:") then
                return obj
            end
        end
        return nil
    end
    
    local function eventLoop()
        while config.autoEvent do
            local eventLabel = findEventLabel()
            if eventLabel then
                while eventLabel and config.autoEvent do
                    ReplicatedStorage.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
                    RunService.Heartbeat:Wait()
                    eventLabel = findEventLabel()
                end
            end
            RunService.Heartbeat:Wait()
        end
    end
    
    local function handleEventTool(tool)
        if config.autoEvent and tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
            tool.Parent = player.Character
        end
    end
    
    smartConnection(player.Backpack.ChildAdded, handleEventTool)
    
    eventButton.MouseButton1Click:Connect(function()
        config.autoEvent = not config.autoEvent
        updateEventButton()
        
        if config.autoEvent then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                handleEventTool(tool)
            end
            task.spawn(eventLoop)
        end
        
        configManager:save(config)
    end)
    
    updateEventButton()
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    return content
end

-- Create tabs
for i, tabData in ipairs(tabs) do
    local button, stroke = uiBuilder:createButton(tabContainer, Theme.sizes.tabButton, UDim2.new(0, 0, 0, 5), tabData.icon .. " " .. tabData.name)
    tabButtons[i] = {button = button, stroke = stroke}
    
    local content
    if i == 1 then
        content = createControlTab()
    elseif i == 2 then
        content = createPlantsTab()
    elseif i == 3 then
        content = createShopTab()
    elseif i == 4 then
        content = createPetsTab()
    elseif i == 5 then
        content = createEventsTab()
    end
    
    tabContents[i] = content
    content.Visible = (i == activeTab)
    
    button.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for j, tabContent in ipairs(tabContents) do
            tabContent.Visible = false
            tabButtons[j].button.BackgroundColor3 = Theme.colors.inactive
            tabButtons[j].stroke.Color = Theme.colors.border
        end
        
        -- Show selected tab
        content.Visible = true
        button.BackgroundColor3 = Theme.colors.accent
        stroke.Color = Theme.colors.accentHover
        activeTab = i
        config.activeTab = i
        configManager:save(config)
    end)
    
    if i == activeTab then
        button.BackgroundColor3 = Theme.colors.accent
        stroke.Color = Theme.colors.accentHover
    end
end

-- Minimize functionality
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 45)
        })
        tween:Play()
        minimizeButton.Text = "+"
        
        tween.Completed:Connect(function()
            tabContainer.Visible = false
            contentContainer.Visible = false
        end)
    else
        tabContainer.Visible = true
        contentContainer.Visible = true
        
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Theme.sizes.mainFrame
        })
        tween:Play()
        minimizeButton.Text = "-"
    end
end)

-- Credits
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Size = UDim2.new(1, 0, 0, 15)
creditsLabel.Position = UDim2.new(0, 0, 1, -20)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "✨ Advanced Version by OneCreatorX"
creditsLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
creditsLabel.TextSize = 10
creditsLabel.Font = Enum.Font.GothamMedium
creditsLabel.TextXAlignment = Enum.TextXAlignment.Center
creditsLabel.Parent = mainFrame

-- Auto-plant connection
smartConnection(player.CharacterAdded, function(character)
    smartConnection(character.ChildAdded, function(child)
        if child:IsA("Tool") and config.autoPlant then
            task.spawn(function()
                automationManager:startAutoPlant()
            end)
        end
    end)
end)

if player.Character then
    smartConnection(player.Character.ChildAdded, function(child)
        if child:IsA("Tool") and config.autoPlant then
            task.spawn(function()
                automationManager:startAutoPlant()
            end)
        end
    end)
end

-- Initialize automation based on saved config
if config.collect then
    automationManager:startCollecting()
end

if config.autoSell then
    automationManager:startAutoSell()
end

-- Cleanup on script end
game:BindToClose(function()
    configManager:save(config)
end)
