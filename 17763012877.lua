local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)
local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local active = false
local damage = p:WaitForChild("Localstats"):WaitForChild("Damage")
local multiplier = p:WaitForChild("Values"):WaitForChild("Multiplier1")
local mt = getrawmetatable(game)
local old_index = mt.__index

setreadonly(mt, false)

mt.__index = function(instance, index)
    if active then
        if instance == damage and index == "Value" then
            return 10000000
        elseif instance == multiplier and index == "Value" then
            return 10000
        end
    end
    return old_index(instance, index)
end

setreadonly(mt, true)

local tp = false
UL:AddTBtn(cfrm, "Inject DMG", false, function() 
    active = not active 
end)
local egge = Basic
local pet = false
UL:AddTBtn(cfrm, "Auto Open Egg", false, function() 
    pet = not pet
    while pet do
        local args = { workspace:WaitForChild("Eggs"):WaitForChild(egge) }
        game:GetService("ReplicatedStorage"):WaitForChild("EggHatchingRemotes"):WaitForChild("HatchServer"):InvokeServer(unpack(args))
        wait()
    end
end)

local EggB, EggF = UL:AddOBtn(cfrm, "Options Egg World")

for _, e in (workspace.Eggs:GetChildren()) do
    UL:AddBtn(EggF, e.Name, function()  egge = e.Name
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "New Open Egg",
    Text = "Is " .. e.Name,
    Duration = 5,
})

 end)
end

local eggg = false
UL:AddTBtn(cfrm, "Auto Hit Block", false, function() 
    eggg = not eggg
    while eggg do
        local area = workspace:WaitForChild("BreakablesByArea")
        for _, obj in ipairs(area:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                obj.MaxActivationDistance = 10000
spawn(function()
pcall(function()
if tp and obj.Parent.Transparency == 0 and not obj.Parent.BillboardGui.Frame.HealthText.Text :find("Cooldown") then
           p.Character.PrimaryPart.CFrame = obj.Parent.CFrame + Vector3.new(0, 2, 0)

end
end)
end)
                fireclickdetector(obj)
wait()
            end
        end
    end
end)
UL:AddTBtn(cfrm, "TP Block", false, function() 
tp = not tp
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 20/06/24 ")
UL:AddText(crFrm, "Update Script: 23/06/24")
UL:AddText(crFrm, "Script Version: 0.4")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
