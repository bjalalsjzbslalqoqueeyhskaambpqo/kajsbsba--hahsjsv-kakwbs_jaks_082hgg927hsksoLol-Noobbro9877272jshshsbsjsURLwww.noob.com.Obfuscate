local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local AutoFight = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("RequestInitFight")

local function gaa()
    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("RequestStartFight"):InvokeServer()
    for i = 1, 5 do
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("RequestPlayerFightModeAttack"):InvokeServer()
    end
end

local ja = false
spawn(function()
    local mt = getrawmetatable(AutoFight)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        if ja then
            spawn(function() gaa() end)
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
end)

function sendNotification(title, text, duration)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration,
    })
end

local running = false
local world = ""

local function startOpeningEggs(world)
    running = true
    while running do
        if world == "" or world:lower() == "stop" then
            running = false
            sendNotification("Stop Open Egg", "Egg opening stopped", 5)
            return
        end

        local newWorld = tonumber(world)
        if newWorld then
            local args = {newWorld, 1}
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("RequestOpenCrate"):InvokeServer(unpack(args))
        else
            -- handle invalid input
        end
        wait(0.1)
    end
end

UL:AddTBox(cfrm, "Auto Egg - Enter world number or 'stop'", function(value)
    world = value
    startOpeningEggs(world)
end)

UL:AddTBtn(cfrm, "OP Fast Farm", false, function()
    ja = not ja 
end)

UL:AddTBtn(cfrm, "Auto Click", false, function(b)
    local a = b
    while a do
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RE"):WaitForChild("PlayerAttackStart"):FireServer()
        wait()
    end
end)

UL:AddTBtn(cfrm, "Auto Rebirth", h, function(uu)
     h = uu
    while h do
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("RequestPurchaseRebirth"):InvokeServer()
        wait(0.5)
    end
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
