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

UL:AddTBtn(cfrm, "Auto Mannequins", a, function(b)
    a = b
    while a do
        local args = {
            [1] = "Placement_onPlace",
            [2] = "mannequin1",
            [3] = game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
            [4] = 270
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Src"):WaitForChild("Shared"):WaitForChild("Btools"):WaitForChild("network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        wait(0.1)
    end
end)

local yaaa = false
UL:AddBtn(cfrm, "200 Buy Mannequins", function()
    local args = {
        [1] = "ItemShop.BuyItem",
        [2] = "mannequin1",
        [3] = -250
    }
     
    game:GetService("ReplicatedStorage").Src.Shared.Btools.network.RemoteFunction:InvokeServer(unpack(args))
    local args = {
        [1] = "ItemShop.BuyItem",
        [2] = "mannequin1",
        [3] = 200
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Src"):WaitForChild("Shared"):WaitForChild("Btools"):WaitForChild("network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args)) 
end)

local Player = game:GetService("Players").LocalPlayer
local ID = Player.UserId
local yaa = false
local style = "1"

local function randomInRange(min, max)
    return math.random(min, max)
end

function iteracion(arg1)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "Loading Avatars",
        Text = "Wait Auto Loader",
        Duration = 4,
    })

    yaa = false
    local start, stop

    local dashIndex = style:find("-")
    if dashIndex then
        start = tonumber(style:sub(1, dashIndex - 1))
        stop = tonumber(style:sub(dashIndex + 1))
    else
        start = tonumber(style)
        stop = tonumber(style)
    end

    for i = arg1 + 1, arg1 + 100 do
        local args = {
            [1] = i,
            [2] = "setStyle",
            [3] = ID.."_".. style
        }
        game:GetService("ReplicatedStorage"):WaitForChild("ReplicaRemoteEvents"):WaitForChild("Replica_ReplicaSignal"):FireServer(unpack(args))
        wait(0.1)
    end

    for i = arg1 - 1, arg1 - 100, -1 do
        local args = {
            [1] = i,
            [2] = "setStyle",
            [3] = ID.."_" .. style
        }
        game:GetService("ReplicatedStorage"):WaitForChild("ReplicaRemoteEvents"):WaitForChild("Replica_ReplicaSignal"):FireServer(unpack(args))
        wait(0.1)
    end

    StarterGui:SetCore("SendNotification", {
        Title = "Finish Avatars",
        Text = "Auto Loader",
        Duration = 2,
    })

    yaa = true
end

local ReplicaRemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("ReplicaRemoteEvents"):WaitForChild("Replica_ReplicaSignal")

local function CustomFireServer(...)
    local args = {...}
    local method = getnamecallmethod()

    if yaaa and yaa and method == "FireServer" and #args >= 1 and type(args[1]) == "number" then
        local arg1 = args[1]

        Spawn(function()
            iteracion(arg1)
        end)
    end

    return ReplicaRemoteEvents[method](ReplicaRemoteEvents, ...)
end

local mt = getrawmetatable(ReplicaRemoteEvents)
if mt then
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if yaaa and yaa and method == "FireServer" and #args >= 1 and type(args[1]) == "number" then
            return CustomFireServer(...)
        end

        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
end

UL:AddTBtn(cfrm, "Auto Loadder Mannequins (Beta)", false, function()
    yaaa = not yaaa
    yaa = true
end)

UL:AddTBox(cfrm, "Use u Styles Loadder use 1, 2, etc", function(text) 
    style = text
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 14/06/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
