local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

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

local a = false
UL:AddTBtn(cfrm, "Auto Collect Bb", false, function(state) 
a = not a
end)

local pName = game.Players.LocalPlayer.Name
local f = game.Workspace:WaitForChild("FX")

f.ChildAdded:Connect(function(c)
    if c.Name == pName and a then
wait(1)
c.Collider.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
    end
end)


UL:AddBtn(cfrm, "Collect Bbs", function()
local player = game.Players.LocalPlayer
local character = player.Character
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
humanoidRootPart.Anchored = true
for _, p in pairs(game.Workspace:GetChildren()) do
    if p:IsA("Part") then
        local tool = p:FindFirstChild(p.Name)
        if tool and tool:IsA("Tool") then
            humanoidRootPart.CFrame = p.CFrame
            wait(1)
            for _, d in pairs(p:GetDescendants()) do
                if d:IsA("ProximityPrompt") then
                    fireproximityprompt(d)
                    wait(1)
                end
            end
        end
    end
end
humanoidRootPart.Anchored = false

end) 


local a = false
UL:AddTBtn(cfrm, "Inf Rewards(Beta)", false, function(state) 
a = not a
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "IMPORTANTE (Inf Recompensas)",
    Text = "Solo funciona esta ves, si sales y entras ya no funcionará",
    Duration = 15,
})

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "only 1 section will work ",
    Text = "If you exit the game you will not be able to use it again.",
    Duration = 15,
})
while a do
game.Players.LocalPlayer.PlayerGui.PlacesLoadingScreen.Enabled = false
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        fireproximityprompt(obj)
wait()
    end
end


wait(1)
end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 08/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


