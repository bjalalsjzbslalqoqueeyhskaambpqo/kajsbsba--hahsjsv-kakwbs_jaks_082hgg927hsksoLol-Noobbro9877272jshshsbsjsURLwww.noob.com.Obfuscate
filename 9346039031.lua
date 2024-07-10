local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local function extract_number(name)
    return tonumber(name:match("%d+"))
end

local b = false

local function detectAndFireButtonEvents(button)
    local activeEvents = {}
    local commonEvents = {"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "InputBegan", "InputEnded"}

    for _, eventName in ipairs(commonEvents) do
        if typeof(button[eventName]) == "RBXScriptSignal" then
            local connections = getconnections(button[eventName])
            if #connections > 0 then
                table.insert(activeEvents, {name = eventName, connections = connections})
            end
        end
    end

    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("BindableEvent") or child:IsA("CustomEvent") then
            local connections = getconnections(child.Event)
            if #connections > 0 then
                table.insert(activeEvents, {name = child.Name, connections = connections})
            end
        end
    end

    if #activeEvents > 0 then
        for _, eventInfo in ipairs(activeEvents) do
            for i, connection in ipairs(eventInfo.connections) do
                if connection.Function and connection.Enabled then
                    pcall(function()
                        connection:Fire()
                    end)
                end
            end
        end
    end
end

local function processCustomers()
    for _, yy in ipairs(workspace.CafeCustomer:GetChildren()) do
        local primaryPart = yy.PrimaryPart
        if primaryPart then
            local UIExpression01 = primaryPart:FindFirstChild("UIExpression01")
            if UIExpression01 and UIExpression01:FindFirstChild("Frame") and UIExpression01.Frame:FindFirstChild("ImageLabel02") then
                local imageLabel = UIExpression01.Frame.ImageLabel02
                if imageLabel.Visible and imageLabel.Image == "rbxassetid://8857033122" then
                    game.Players.LocalPlayer.Character:MoveTo(primaryPart.Position)
                    wait(0.2)
                    if game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].Visible then
                        local button = game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].ImageButton
                        if button and button:IsA("GuiButton") then
                            detectAndFireButtonEvents(button)
                            wait(0.4)
                        end
                    end
                end
            end
        end
    end
end

local function processOperatePoints()
    for _, yy in ipairs(workspace.OperatePoints:GetChildren()) do
        if yy.Name == "Part" then
            local UIBubble = yy:FindFirstChild("UIBubble")
            if UIBubble and UIBubble:FindFirstChild("Frame") and UIBubble.Frame:FindFirstChild("Coin") then
                local coin = UIBubble.Frame.Coin
                if coin.Visible then
                    game.Players.LocalPlayer.Character:MoveTo(yy.Position)
                    wait(0.2)
                    if game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].Visible then
                        local button = game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].ImageButton
                        if button and button:IsA("GuiButton") then
                            detectAndFireButtonEvents(button)
                            wait(0.1)
                        end
                    end
                end
            end
        end
    end
end

local function moveToStartPosition()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-2.26451278, 2.1982038, 115.916199))
end

local function processButtonIfVisible()
    wait(0.6)
    if game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].Visible then
        local button = game.Players.LocalPlayer.PlayerGui.UIPlayer.UIPlayerInteraction["Interaction-InteractionF"].ImageButton
        if button and button:IsA("GuiButton") then
            detectAndFireButtonEvents(button)
        end
    end
end

function trasure()
for _, t in pairs(workspace.TreasureEntity:GetChildren()) do
    game.Players.LocalPlayer.Character:MoveTo(t:GetModelCFrame().Position)
    wait(0.5)
        processButtonIfVisible()
wait(2.2)
end
end

UL:AddTBtn(cfrm, "Auto Treasure", false, function()
 tre = not tre

while tre do
trasure()
wait(1)
end
end)


local function mainLoop()
    while b do
        processCustomers()
        processOperatePoints()
        moveToStartPosition()
        processButtonIfVisible()
        wait(1)
    end
wait()
end



UL:AddTBtn(cfrm, "Auto All", false, function()
    b = not b
if b then
mainLoop()
else
end
end)

local remote = game:GetService("ReplicatedStorage"):WaitForChild("GameCommon"):WaitForChild("Messages"):WaitForChild("Interaction"):WaitForChild("OperatePart")

local arg1_main = 32
local arg1_order = nil

local mt = getrawmetatable(remote)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local arg1 = args[1]
    local arg2 = args[2]

    if arg2 == "TakeMain" then
        arg1_main = arg1
    elseif arg2 == "TakeOrder" then
        arg1_order = arg1
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

local a = false

UL:AddTBtn(cfrm, "Auto fast Order", false, function()
    a = not a
    if arg1_order == nil then
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("SendNotification", {
            Title = "First use: take Order",
            Text = "Then use: take Main",
            Duration = 5,
        })
        StarterGui:SetCore("SendNotification", {
            Title = "Prepare a manual order first",
            Text = "and try to activate again",
            Duration = 5,
        })
    else
        while a do
            local args = {
                [1] = arg1_order,
                [2] = "TakeOrder"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("GameCommon"):WaitForChild("Messages"):WaitForChild("Interaction"):WaitForChild("OperatePart"):FireServer(unpack(args))

            local args = {
                [1] = arg1_main,
                [2] = "TakeMain"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("GameCommon"):WaitForChild("Messages"):WaitForChild("Interaction"):WaitForChild("OperatePart"):FireServer(unpack(args))

            wait(0.5)
        end
    end
end)

local RS = game:GetService("ReplicatedStorage")
local syncPlayerOrderInfo = RS:WaitForChild("GameCommon"):WaitForChild("Messages"):WaitForChild("Interaction"):WaitForChild("SyncPlayerOrderInfo")
local finishOrderRecipes = RS:WaitForChild("GameCommon"):WaitForChild("Messages"):WaitForChild("Interaction"):WaitForChild("FinishOrderRecipes")

syncPlayerOrderInfo.OnClientEvent:Connect(function(data, arg2)
    if a and type(data) == "table" and data.seatNum and data.tablePartID then
        local args = {
            [1] = data.tablePartID,
            [2] = data.seatNum
        }
        finishOrderRecipes:FireServer(unpack(args))
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 05/07/24 ")
UL:AddText(crFrm, "Update Script: 10/07/--")
UL:AddText(crFrm, "Script Version: 0.3")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
